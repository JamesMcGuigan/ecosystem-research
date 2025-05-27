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