import torch
from torch import nn, optim
from sklearn import datasets
from torch.utils.data import TensorDataset, DataLoader

# 1) Data
iris = datasets.load_iris()
X = torch.tensor(iris.data, dtype=torch.float32)
y = torch.tensor(iris.target, dtype=torch.long)
dataset    = TensorDataset(X, y)
dataloader = DataLoader(dataset, batch_size=32)


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
epochs = 200
for epoch in range(1, epochs+1):
    for batch_X, batch_y in dataloader:
        optimizer.zero_grad()
        # logits = model(X)
        # loss = criterion(logits, y)
        logits = model(batch_X)
        loss = criterion(logits, batch_y)
        loss.backward()
        optimizer.step()
    if epoch % 20 == 0:
        print(f"Epoch {epoch:03d} — Loss: {loss.item():.4f}")

# 4) Evaluate
with torch.no_grad():
    preds = model(X).argmax(dim=1)
    acc = (preds == y).float().mean()
print(f"Final train accuracy: {acc:.2%}")