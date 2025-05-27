# PyTorch training loop on the classic Iris classification task 

Let’s build a minimal PyTorch training loop on the classic Iris classification task. We’ll go step by step, from first principles.

- https://chatgpt.com/c/683582e8-d720-8004-bef9-f2c850e8ea3c

---

## 1. Problem setup

The Iris dataset has 150 samples, each with 4 features $x\in\mathbb{R}^4$ and one of 3 target classes $y\in\{0,1,2\}$. We want a model $f_\theta:\mathbb{R}^4\to\mathbb{R}^3$ that, given $x$, outputs logits $\ell=f_\theta(x)$, which we turn into probabilities via softmax:

$$
\hat p_i = \frac{e^{\ell_i}}{\sum_{j=1}^3 e^{\ell_j}}.
$$

We train by minimizing the **cross-entropy loss**:

$$
\mathcal{L}(\theta) = -\frac1N\sum_{n=1}^N \sum_{i=1}^3 \mathbf{1}\{y^{(n)}=i\}\,\log \hat p_i^{(n)}.
$$

---

## 2. Data preparation

1. **Load** via `sklearn.datasets.load_iris()`.
2. **Convert** to PyTorch tensors:

   $$
   X\in\mathbb{R}^{150\times4},\quad y\in\{0,1,2\}^{150}.
   $$
3. **Optional:** split into train/test or use full data for demonstration.

---

## 3. Model definition

A **simple feed-forward net**:

* Input layer: 4 units
* Hidden layer: 16 units, ReLU
* Output layer: 3 units (logits)

```python
import torch
import torch.nn as nn

class IrisNet(nn.Module):
    def __init__(self):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(4, 16),
            nn.ReLU(),
            nn.Linear(16, 3)
        )
    def forward(self, x):
        return self.net(x)
```

---

## 4. Training loop

1. **Instantiate**

   ```python
   model = IrisNet()
   criterion = nn.CrossEntropyLoss()     # implements the loss above
   optimizer = torch.optim.SGD(model.parameters(), lr=0.1)
   ```
2. **Loop** for $E$ epochs:

   ```python
   for epoch in range(E):
       optimizer.zero_grad()              # ⎯ clear old gradients
       logits = model(X_train)            # ⎯ forward pass
       loss = criterion(logits, y_train)  # ⎯ compute ℒ
       loss.backward()                    # ⎯ backpropagate ∇θℒ
       optimizer.step()                   # ⎯ apply gradient step
       if epoch % 10 == 0:
           print(f"Epoch {epoch:03d}  Loss: {loss.item():.4f}")
   ```
3. **Evaluate** accuracy on train (or hold-out) set:

   ```python
   with torch.no_grad():
       preds = model(X_train).argmax(dim=1)
       acc = (preds == y_train).float().mean()
   print(f"Train accuracy: {acc:.2%}")
   ```

---

## 5. Full example

```python
import torch
from torch import nn, optim
from sklearn import datasets

# 1) Data
iris = datasets.load_iris()
X = torch.tensor(iris.data, dtype=torch.float32)
y = torch.tensor(iris.target, dtype=torch.long)

# 2) Model
class IrisNet(nn.Module):
    def __init__(self):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(4, 16),
            nn.ReLU(),
            nn.Linear(16, 3)
        )
    def forward(self, x):
        return self.net(x)

model = IrisNet()
criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr=0.1)

# 3) Train
epochs = 100
for epoch in range(1, epochs+1):
    optimizer.zero_grad()
    logits = model(X)
    loss = criterion(logits, y)
    loss.backward()
    optimizer.step()
    if epoch % 20 == 0:
        print(f"Epoch {epoch:03d} — Loss: {loss.item():.4f}")

# 4) Evaluate
with torch.no_grad():
    preds = model(X).argmax(dim=1)
    acc = (preds == y).float().mean()
print(f"Final train accuracy: {acc:.2%}")
```

---

## 6. Next steps & prompting feedback

* **DataLoader & batching:** wrap $(X,y)$ in a `TensorDataset` + `DataLoader` to train on mini-batches rather than full-batch.
* **Validation split:** always good to hold out 20% for generalization checks.
* **Optimization:** try Adam, learning-rate schedules.
* **Metrics & plots:** record loss/accuracy per epoch and visualize.

**Prompting tips:**

* Specify whether you want batching, GPU support, or custom architectures.
* If you expect plotting of curves, mention that to trigger `python_user_visible` for charts.
* For more complex tasks (e.g. multi-class imbalanced data), note if you want weighted losses or sampling.

**Questions for you:**

* Do you want to see a batched `DataLoader` version?
* Would you like me to demonstrate plotting training curves?
* Do you need GPU/CUDA configuration included?

---

⭐ **Confidence:** High
