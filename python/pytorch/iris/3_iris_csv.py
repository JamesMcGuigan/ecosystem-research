import pandas as pd
import torch
from torch import nn, optim
from sklearn import datasets
from torch.utils.data import TensorDataset, DataLoader

# 1) Data
df = pd.read_csv("iris.csv")
df["species"] = pd.Categorical(df["species"])
X = torch.tensor(df.drop("species", axis=1).values, dtype=torch.float32)
y = torch.tensor(df["species"].cat.codes.values, dtype=torch.long)
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
epochs = 100
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