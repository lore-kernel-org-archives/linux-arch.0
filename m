From: Richard Henderson <rth@twiddle.net>
Subject: [PATCH] alpha: provide ioread64 and iowrite64 implementations
Date: Sat, 24 Jun 2017 08:13:08 -0700
Message-ID: <20170624151308.6348-1-rth@twiddle.net>
References: <20170624115707.30095-1-horia.geanta@nxp.com>
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20170624115707.30095-1-horia.geanta@nxp.com>
Sender: linux-alpha-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
List-Id: linux-arch.vger.kernel.org

All Alpha hosts except for Jensen provide 64-bit I/O operations.

Jensen is EISA only, so there ought not be any devices that even
attempt such operations.  But just in case, use 2 32-bit operations.

Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 arch/alpha/include/asm/core_apecs.h  | 16 ++++++++++++++++
 arch/alpha/include/asm/core_cia.h    | 16 ++++++++++++++++
 arch/alpha/include/asm/core_lca.h    | 16 ++++++++++++++++
 arch/alpha/include/asm/core_mcpcia.h | 21 +++++++++++++++++++++
 arch/alpha/include/asm/core_t2.h     | 24 +++++++++++++++++++-----
 arch/alpha/include/asm/io.h          | 27 +++++++++++++++++++++++++++
 arch/alpha/include/asm/io_trivial.h  | 12 ++++++++++++
 arch/alpha/include/asm/jensen.h      | 32 +++++++++++++++++++++++++++-----
 arch/alpha/include/asm/machvec.h     |  2 ++
 arch/alpha/kernel/io.c               | 27 +++++++++++++++++++++++++++
 arch/alpha/kernel/machvec_impl.h     |  2 ++
 11 files changed, 185 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/include/asm/core_apecs.h b/arch/alpha/include/asm/core_apecs.h
index 6785ff7..7e2ff13 100644
--- a/arch/alpha/include/asm/core_apecs.h
+++ b/arch/alpha/include/asm/core_apecs.h
@@ -471,6 +471,22 @@ __EXTERN_INLINE void apecs_iowrite32(u32 b, void __iomem *xaddr)
 	*(vuip)addr = b;
 }
 
+__EXTERN_INLINE u64 apecs_ioread64(void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < APECS_DENSE_MEM)
+		addr = ((addr - APECS_IO) << 5) + APECS_IO + 0x78;
+	return *(vulp)addr;
+}
+
+__EXTERN_INLINE void apecs_iowrite64(u64 b, void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < APECS_DENSE_MEM)
+		addr = ((addr - APECS_IO) << 5) + APECS_IO + 0x78;
+	*(vulp)addr = b;
+}
+
 __EXTERN_INLINE void __iomem *apecs_ioportmap(unsigned long addr)
 {
 	return (void __iomem *)(addr + APECS_IO);
diff --git a/arch/alpha/include/asm/core_cia.h b/arch/alpha/include/asm/core_cia.h
index 9e0516c..54792b3 100644
--- a/arch/alpha/include/asm/core_cia.h
+++ b/arch/alpha/include/asm/core_cia.h
@@ -419,6 +419,22 @@ __EXTERN_INLINE void cia_iowrite32(u32 b, void __iomem *xaddr)
 	*(vuip)addr = b;
 }
 
+__EXTERN_INLINE u64 cia_ioread64(void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < CIA_DENSE_MEM)
+		addr = ((addr - CIA_IO) << 5) + CIA_IO + 0x78;
+	return *(vulp)addr;
+}
+
+__EXTERN_INLINE void cia_iowrite64(u64 b, void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < CIA_DENSE_MEM)
+		addr = ((addr - CIA_IO) << 5) + CIA_IO + 0x78;
+	*(vulp)addr = b;
+}
+
 __EXTERN_INLINE void __iomem *cia_ioportmap(unsigned long addr)
 {
 	return (void __iomem *)(addr + CIA_IO);
diff --git a/arch/alpha/include/asm/core_lca.h b/arch/alpha/include/asm/core_lca.h
index 8ee6c51..b8e43cd 100644
--- a/arch/alpha/include/asm/core_lca.h
+++ b/arch/alpha/include/asm/core_lca.h
@@ -317,6 +317,22 @@ __EXTERN_INLINE void lca_iowrite32(u32 b, void __iomem *xaddr)
 	*(vuip)addr = b;
 }
 
+__EXTERN_INLINE u64 lca_ioread64(void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < LCA_DENSE_MEM)
+		addr = ((addr - LCA_IO) << 5) + LCA_IO + 0x78;
+	return *(vulp)addr;
+}
+
+__EXTERN_INLINE void lca_iowrite64(u64 b, void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < LCA_DENSE_MEM)
+		addr = ((addr - LCA_IO) << 5) + LCA_IO + 0x78;
+	*(vulp)addr = b;
+}
+
 __EXTERN_INLINE void __iomem *lca_ioportmap(unsigned long addr)
 {
 	return (void __iomem *)(addr + LCA_IO);
diff --git a/arch/alpha/include/asm/core_mcpcia.h b/arch/alpha/include/asm/core_mcpcia.h
index ad44bef..e4d9139 100644
--- a/arch/alpha/include/asm/core_mcpcia.h
+++ b/arch/alpha/include/asm/core_mcpcia.h
@@ -247,6 +247,7 @@ struct el_MCPCIA_uncorrected_frame_mcheck {
 
 #define vip	volatile int __force *
 #define vuip	volatile unsigned int __force *
+#define vulp	volatile unsigned long __force *
 
 #ifndef MCPCIA_ONE_HAE_WINDOW
 #define MCPCIA_FROB_MMIO						\
@@ -334,6 +335,25 @@ __EXTERN_INLINE void mcpcia_iowrite32(u32 b, void __iomem *xaddr)
 	*(vuip)addr = b;
 }
 
+__EXTERN_INLINE u64 mcpcia_ioread64(void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long)xaddr;
+
+	if (!__mcpcia_is_mmio(addr))
+		addr = ((addr & 0xffff) << 5) + (addr & ~0xfffful) + 0x78;
+
+	return *(vulp)addr;
+}
+
+__EXTERN_INLINE void mcpcia_iowrite64(u64 b, void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long)xaddr;
+
+	if (!__mcpcia_is_mmio(addr))
+		addr = ((addr & 0xffff) << 5) + (addr & ~0xfffful) + 0x78;
+
+	*(vulp)addr = b;
+}
 
 __EXTERN_INLINE void __iomem *mcpcia_ioportmap(unsigned long addr)
 {
@@ -361,6 +381,7 @@ __EXTERN_INLINE int mcpcia_is_mmio(const volatile void __iomem *xaddr)
 
 #undef vip
 #undef vuip
+#undef vulp
 
 #undef __IO_PREFIX
 #define __IO_PREFIX		mcpcia
diff --git a/arch/alpha/include/asm/core_t2.h b/arch/alpha/include/asm/core_t2.h
index ade9d92..cb3467d 100644
--- a/arch/alpha/include/asm/core_t2.h
+++ b/arch/alpha/include/asm/core_t2.h
@@ -359,6 +359,7 @@ struct el_t2_frame_corrected {
 
 #define vip	volatile int *
 #define vuip	volatile unsigned int *
+#define vulp	volatile unsigned long *
 
 extern inline u8 t2_inb(unsigned long addr)
 {
@@ -401,6 +402,17 @@ extern inline void t2_outl(u32 b, unsigned long addr)
 	mb();
 }
 
+extern inline u64 t2_inq(unsigned long addr)
+{
+	return *(vulp) ((addr << 5) + T2_IO + 0x78);
+}
+
+extern inline void t2_outq(u64 b, unsigned long addr)
+{
+	*(vulp) ((addr << 5) + T2_IO + 0x78) = b;
+	mb();
+}
+
 
 /*
  * Memory functions.
@@ -570,8 +582,8 @@ __EXTERN_INLINE int t2_is_mmio(const volatile void __iomem *addr)
 /* New-style ioread interface.  The mmio routines are so ugly for T2 that
    it doesn't make sense to merge the pio and mmio routines.  */
 
-#define IOPORT(OS, NS)							\
-__EXTERN_INLINE unsigned int t2_ioread##NS(void __iomem *xaddr)		\
+#define IOPORT(OS, NS, RT)						\
+__EXTERN_INLINE RT t2_ioread##NS(void __iomem *xaddr)		\
 {									\
 	if (t2_is_mmio(xaddr))						\
 		return t2_read##OS(xaddr);				\
@@ -586,14 +598,16 @@ __EXTERN_INLINE void t2_iowrite##NS(u##NS b, void __iomem *xaddr)	\
 		t2_out##OS(b, (unsigned long)xaddr - T2_IO);		\
 }
 
-IOPORT(b, 8)
-IOPORT(w, 16)
-IOPORT(l, 32)
+IOPORT(b, 8, unsigned int)
+IOPORT(w, 16, unsigned int)
+IOPORT(l, 32, unsigned int)
+IOPORT(q, 64, u64)
 
 #undef IOPORT
 
 #undef vip
 #undef vuip
+#undef vulp
 
 #undef __IO_PREFIX
 #define __IO_PREFIX		t2
diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index ff40491..16426e8 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -158,6 +158,7 @@ static inline void generic_##NAME(TYPE b, QUAL void __iomem *addr)	\
 REMAP1(unsigned int, ioread8, /**/)
 REMAP1(unsigned int, ioread16, /**/)
 REMAP1(unsigned int, ioread32, /**/)
+REMAP1(u64, ioread64, /**/)
 REMAP1(u8, readb, const volatile)
 REMAP1(u16, readw, const volatile)
 REMAP1(u32, readl, const volatile)
@@ -166,6 +167,7 @@ REMAP1(u64, readq, const volatile)
 REMAP2(u8, iowrite8, /**/)
 REMAP2(u16, iowrite16, /**/)
 REMAP2(u32, iowrite32, /**/)
+REMAP2(u64, iowrite64, /**/)
 REMAP2(u8, writeb, volatile)
 REMAP2(u16, writew, volatile)
 REMAP2(u32, writel, volatile)
@@ -384,6 +386,19 @@ extern inline void iowrite32(u32 b, void __iomem *addr)
 	mb();
 }
 
+extern inline u64 ioread64(void __iomem *addr)
+{
+	unsigned int ret = IO_CONCAT(__IO_PREFIX,ioread64)(addr);
+	mb();
+	return ret;
+}
+
+extern inline void iowrite64(u64 b, void __iomem *addr)
+{
+	IO_CONCAT(__IO_PREFIX,iowrite64)(b, addr);
+	mb();
+}
+
 extern inline u32 inl(unsigned long port)
 {
 	return ioread32(ioport_map(port, 4));
@@ -393,6 +408,16 @@ extern inline void outl(u32 b, unsigned long port)
 {
 	iowrite32(b, ioport_map(port, 4));
 }
+
+extern inline u64 inq(unsigned long port)
+{
+	return ioread64(ioport_map(port, 8));
+}
+
+extern inline void outq(u64 b, unsigned long port)
+{
+	iowrite64(b, ioport_map(port, 8));
+}
 #endif
 
 #if IO_CONCAT(__IO_PREFIX,trivial_rw_bw) == 1
@@ -493,8 +518,10 @@ extern inline void writeq(u64 b, volatile void __iomem *addr)
 
 #define ioread16be(p) be16_to_cpu(ioread16(p))
 #define ioread32be(p) be32_to_cpu(ioread32(p))
+#define ioread64be(p) be64_to_cpu(ioread64(p))
 #define iowrite16be(v,p) iowrite16(cpu_to_be16(v), (p))
 #define iowrite32be(v,p) iowrite32(cpu_to_be32(v), (p))
+#define iowrite64be(v,p) iowrite64(cpu_to_be64(v), (p))
 
 #define inb_p		inb
 #define inw_p		inw
diff --git a/arch/alpha/include/asm/io_trivial.h b/arch/alpha/include/asm/io_trivial.h
index 1c77f10..ae97730 100644
--- a/arch/alpha/include/asm/io_trivial.h
+++ b/arch/alpha/include/asm/io_trivial.h
@@ -37,11 +37,23 @@ IO_CONCAT(__IO_PREFIX,ioread32)(void __iomem *a)
 	return *(volatile u32 __force *)a;
 }
 
+__EXTERN_INLINE u64
+IO_CONCAT(__IO_PREFIX,ioread64)(void __iomem *a)
+{
+	return *(volatile u64 __force *)a;
+}
+
 __EXTERN_INLINE void
 IO_CONCAT(__IO_PREFIX,iowrite32)(u32 b, void __iomem *a)
 {
 	*(volatile u32 __force *)a = b;
 }
+
+__EXTERN_INLINE void
+IO_CONCAT(__IO_PREFIX,iowrite64)(u64 b, void __iomem *a)
+{
+	*(volatile u64 __force *)a = b;
+}
 #endif
 
 #if IO_CONCAT(__IO_PREFIX,trivial_rw_bw) == 1
diff --git a/arch/alpha/include/asm/jensen.h b/arch/alpha/include/asm/jensen.h
index 964b06e..7e945cf 100644
--- a/arch/alpha/include/asm/jensen.h
+++ b/arch/alpha/include/asm/jensen.h
@@ -182,6 +182,17 @@ __EXTERN_INLINE u32 jensen_inl(unsigned long addr)
 	return *(vuip) ((addr << 7) + EISA_IO + 0x60);
 }
 
+__EXTERN_INLINE u64 jensen_inq(unsigned long addr)
+{
+	unsigned long ioaddr = (addr << 7) + EISA_IO + 0x60;
+	unsigned long l, h;
+
+	jensen_set_hae(0);
+	l = *(vuip)ioaddr;
+	h = *(vuip)(ioaddr + (4 << 7));
+	return h << 32 | l;
+}
+
 __EXTERN_INLINE void jensen_outw(u16 b, unsigned long addr)
 {
 	jensen_set_hae(0);
@@ -196,6 +207,16 @@ __EXTERN_INLINE void jensen_outl(u32 b, unsigned long addr)
 	mb();
 }
 
+__EXTERN_INLINE void jensen_outq(u64 b, unsigned long addr)
+{
+	unsigned long ioaddr = (addr << 7) + EISA_IO + 0x60;
+
+	jensen_set_hae(0);
+	*(vuip)ioaddr = b;
+	*(vuip)(ioaddr + (4 << 7)) = b >> 32;
+	mb();
+}
+
 /*
  * Memory functions.
  */
@@ -303,8 +324,8 @@ __EXTERN_INLINE int jensen_is_mmio(const volatile void __iomem *addr)
 /* New-style ioread interface.  All the routines are so ugly for Jensen
    that it doesn't make sense to merge them.  */
 
-#define IOPORT(OS, NS)							\
-__EXTERN_INLINE unsigned int jensen_ioread##NS(void __iomem *xaddr)	\
+#define IOPORT(OS, NS, RT)						\
+__EXTERN_INLINE RT jensen_ioread##NS(void __iomem *xaddr)		\
 {									\
 	if (jensen_is_mmio(xaddr))					\
 		return jensen_read##OS(xaddr - 0x100000000ul);		\
@@ -319,9 +340,10 @@ __EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)	\
 		jensen_out##OS(b, (unsigned long)xaddr);		\
 }
 
-IOPORT(b, 8)
-IOPORT(w, 16)
-IOPORT(l, 32)
+IOPORT(b, 8, unsigned int)
+IOPORT(w, 16, unsigned int)
+IOPORT(l, 32, unsigned int)
+IOPORT(q, 64, u64)
 
 #undef IOPORT
 
diff --git a/arch/alpha/include/asm/machvec.h b/arch/alpha/include/asm/machvec.h
index 75cb364..c037c7b 100644
--- a/arch/alpha/include/asm/machvec.h
+++ b/arch/alpha/include/asm/machvec.h
@@ -48,10 +48,12 @@ struct alpha_machine_vector
 	unsigned int (*mv_ioread8)(void __iomem *);
 	unsigned int (*mv_ioread16)(void __iomem *);
 	unsigned int (*mv_ioread32)(void __iomem *);
+	u64 (*mv_ioread64)(void __iomem *);
 
 	void (*mv_iowrite8)(u8, void __iomem *);
 	void (*mv_iowrite16)(u16, void __iomem *);
 	void (*mv_iowrite32)(u32, void __iomem *);
+	void (*mv_iowrite64)(u64, void __iomem *);
 
 	u8 (*mv_readb)(const volatile void __iomem *);
 	u16 (*mv_readw)(const volatile void __iomem *);
diff --git a/arch/alpha/kernel/io.c b/arch/alpha/kernel/io.c
index 19c5875..d36146f 100644
--- a/arch/alpha/kernel/io.c
+++ b/arch/alpha/kernel/io.c
@@ -34,6 +34,13 @@ unsigned int ioread32(void __iomem *addr)
 	return ret;
 }
 
+u64 ioread64(void __iomem *addr)
+{
+	u64 ret = IO_CONCAT(__IO_PREFIX,ioread64)(addr);
+	mb();
+	return ret;
+}
+
 void iowrite8(u8 b, void __iomem *addr)
 {
 	IO_CONCAT(__IO_PREFIX,iowrite8)(b, addr);
@@ -52,12 +59,20 @@ void iowrite32(u32 b, void __iomem *addr)
 	mb();
 }
 
+void iowrite64(u64 b, void __iomem *addr)
+{
+	IO_CONCAT(__IO_PREFIX,iowrite64)(b, addr);
+	mb();
+}
+
 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
 EXPORT_SYMBOL(ioread32);
+EXPORT_SYMBOL(ioread64);
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
 EXPORT_SYMBOL(iowrite32);
+EXPORT_SYMBOL(iowrite64);
 
 u8 inb(unsigned long port)
 {
@@ -74,6 +89,11 @@ u32 inl(unsigned long port)
 	return ioread32(ioport_map(port, 4));
 }
 
+u64 inq(unsigned long port)
+{
+	return ioread64(ioport_map(port, 8));
+}
+
 void outb(u8 b, unsigned long port)
 {
 	iowrite8(b, ioport_map(port, 1));
@@ -89,12 +109,19 @@ void outl(u32 b, unsigned long port)
 	iowrite32(b, ioport_map(port, 4));
 }
 
+void outq(u64 b, unsigned long port)
+{
+	iowrite64(b, ioport_map(port, 8));
+}
+
 EXPORT_SYMBOL(inb);
 EXPORT_SYMBOL(inw);
 EXPORT_SYMBOL(inl);
+EXPORT_SYMBOL(inq);
 EXPORT_SYMBOL(outb);
 EXPORT_SYMBOL(outw);
 EXPORT_SYMBOL(outl);
+EXPORT_SYMBOL(outq);
 
 u8 __raw_readb(const volatile void __iomem *addr)
 {
diff --git a/arch/alpha/kernel/machvec_impl.h b/arch/alpha/kernel/machvec_impl.h
index b7d6960..9b37e19 100644
--- a/arch/alpha/kernel/machvec_impl.h
+++ b/arch/alpha/kernel/machvec_impl.h
@@ -79,9 +79,11 @@
 	.mv_ioread8 =		CAT(low,_ioread8),			\
 	.mv_ioread16 =		CAT(low,_ioread16),			\
 	.mv_ioread32 =		CAT(low,_ioread32),			\
+	.mv_ioread64 =		CAT(low,_ioread64),			\
 	.mv_iowrite8 =		CAT(low,_iowrite8),			\
 	.mv_iowrite16 =		CAT(low,_iowrite16),			\
 	.mv_iowrite32 =		CAT(low,_iowrite32),			\
+	.mv_iowrite64 =		CAT(low,_iowrite64),			\
 	.mv_readb =		CAT(low,_readb),			\
 	.mv_readw =		CAT(low,_readw),			\
 	.mv_readl =		CAT(low,_readl),			\
-- 
2.9.4

