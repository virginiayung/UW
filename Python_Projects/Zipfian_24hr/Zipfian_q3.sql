select S.ID as Salesperson_ID, S.Name, S.Age, S.Salary, Count(O.Number) as Num_Order, Sum(O.Amount)as Total_Amount
from Salesperson S
Inner Join Orders O on S.ID = O.salesperson_id
Group by O.salesperson_id 
Having Num_Order > 1;


