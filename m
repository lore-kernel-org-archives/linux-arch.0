From: changbin.du@intel.com
Subject: [PATCH v2 2/5] regulator: add dummy function of_find_regulator_by_node
Date: Wed,  2 May 2018 21:44:57 +0800
Message-ID: <1525268700-10631-3-git-send-email-changbin.du@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-arch.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

If device tree is not enabled, of_find_regulator_by_node() should have
a dummy function since the function call is still there.

This is to fix build error after CONFIG_NO_AUTO_INLINE is introduced.
If this option is enabled, GCC will not auto-inline functions that are
not explicitly marked as inline.

In this case (no CONFIG_OF), the copmiler will report error in function
regulator_dev_lookup().

W/O NO_AUTO_INLINE, function of_get_regulator() is auto-inlined and then
the call to of_find_regulator_by_node() is optimized out since
of_get_regulator() always return NULL.

W/ NO_AUTO_INLINE, the return value of of_get_regulator() is a variable
so the call to of_find_regulator_by_node() cannot be optimized out. So
we need a stub of_find_regulator_by_node().

static struct regulator_dev *regulator_dev_lookup(struct device *dev,
						  const char *supply)
{
	struct regulator_dev *r = NULL;
	struct device_node *node;
	struct regulator_map *map;
	const char *devname = NULL;

	regulator_supply_alias(&dev, &supply);

	/* first do a dt based lookup */
	if (dev && dev->of_node) {
		node = of_get_regulator(dev, supply);
		if (node) {
			r = of_find_regulator_by_node(node);
			if (r)
				return r;
	...

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 drivers/regulator/internal.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index abfd56e..24fde1e 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -56,14 +56,19 @@ static inline struct regulator_dev *dev_to_rdev(struct device *dev)
 	return container_of(dev, struct regulator_dev, dev);
 }
 
-struct regulator_dev *of_find_regulator_by_node(struct device_node *np);
-
 #ifdef CONFIG_OF
+struct regulator_dev *of_find_regulator_by_node(struct device_node *np);
 struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 			         const struct regulator_desc *desc,
 				 struct regulator_config *config,
 				 struct device_node **node);
 #else
+static inline struct regulator_dev *
+of_find_regulator_by_node(struct device_node *np)
+{
+	return NULL;
+}
+
 static inline struct regulator_init_data *
 regulator_of_get_init_data(struct device *dev,
 			   const struct regulator_desc *desc,
-- 
2.7.4
