Insud <- data.frame(groups = replicate(500, { sample(c("I", "A"), 1)}), policy = replicate(500, { sample(seq(from = 0, to = 1000), 1)}), gender = replicate(500, { sample(c("M", "F"), 1)})) ## Let's make it very sparse

Insud$policyF <- factor(Insud$policy, levels = seq(from = 0, to = 1000))
t(table(Insud$groups, Insud$policyF)) #you can see empty factor is preseved
require(plyr)

dlply(Insud, .(gender), function(x) t(table(x$groups, x$policyF))) ### I think dl is cleaner than dd.
