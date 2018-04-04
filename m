From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
Date: Wed, 4 Apr 2018 11:52:20 -0400
Message-ID: <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
References: <mhng-fe49c525-788d-4ce7-9703-95e2b3eaeca6@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mhng-fe49c525-788d-4ce7-9703-95e2b3eaeca6@palmer-si-x1c4>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@sifive.com>, Arnd Bergmann <arnd@arndb.de>
Cc: mark.rutland@arm.com, timur@codeaurora.org, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 4/3/2018 6:29 PM, Palmer Dabbelt wrote:
> On Tue, 03 Apr 2018 05:56:18 PDT (-0700), Arnd Bergmann wrote:
>> On Tue, Apr 3, 2018 at 2:44 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> On 4/3/2018 7:13 AM, Arnd Bergmann wrote:
>>>> On Tue, Apr 3, 2018 at 12:49 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On Fri, Mar 30, 2018 at 11:58:13AM -0400, Sinan Kaya wrote:
>>>>>> The default implementation of mapping readX() to __raw_readX() is wrong.
>>>>>> readX() has stronger ordering semantics. Compiler is allowed to reorder
>>>>>> __raw_readX().
>>>>>
>>>>> Could you please specify what the compiler is potentially reordering
>>>>> __raw_readX() against, and why this would be wrong?
>>>>>
>>>>> e.g. do we care about prior normal memory accesses, subsequent normal
>>>>> memory accesses, and/or other IO accesses?
>>>>>
>>>>> I assume that the asm-generic __raw_{read,write}X() implementations are
>>>>> all ordered w.r.t. each other (at least for a specific device).
>>>>
>>>> I think that is correct: the compiler won't reorder those because of the
>>>> 'volatile' pointer dereference, but it can reorder access to a normal
>>>> pointer against a __raw_readl()/__raw_writel(), which breaks the scenario
>>>> of using writel to trigger a DMA, or using a readl to see if a DMA has
>>>> completed.
>>>
>>> Yes, we are worried about memory update vs. IO update ordering here.
>>> That was the reason why barrier() was introduced in this patch. I'll try to
>>> clarify that better in the commit text.
>>>
>>>>
>>>> The question is whether we should use a stronger barrier such
>>>> as rmb() amd wmb() here rather than a simple compiler barrier.
>>>>
>>>> I would assume that on complex architectures with write buffers and
>>>> out-of-order prefetching, those are required, while on architectures
>>>> without those features, the barriers are cheap.
>>>
>>> That's my reasoning too. I'm trying to follow the x86 example here where there
>>> is a compiler barrier in writeX() and readX() family of functions.
>>
>> I think x86 is the special case here because it implicitly guarantees
>> the strict ordering in the hardware, as long as the compiler gets it
>> right. For the asm-generic version, it may be better to play safe and
>> do the safest version, requiring architectures to override that barrier
>> if they want to be faster.
>>
>> We could use the same macros that riscv has, using __io_br(),
>> __io_ar(), __io_bw() and __io_aw() for before/after read/write.
> 
> FWIW, when I wrote this I wasn't sure what the RISC-V memory model was going to be so I just picked something generic.  In other words, it's already a generic interface, just one that we're the only users of :).
> 

Are we looking for something like this?


diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index e8c2078..693a82f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -101,6 +101,16 @@ static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
 #endif
 #endif /* CONFIG_64BIT */
 
+#ifndef __io_br()
+#define __io_br()	do {} while (0)
+#endif
+
+#ifdef rmb
+#define __io_ar()	rmb();
+#else
+#define __io_ar()	barrier();
+#endif
+
 /*
  * {read,write}{b,w,l,q}() access little endian memory and return result in
  * native endianness.
@@ -108,35 +118,46 @@ static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
 
 #ifndef readb
 #define readb readb
-static inline u8 readb(const volatile void __iomem *addr)
-{
-	return __raw_readb(addr);
-}
+#define readb(c)				\
+	({ u8  __v;				\
+	 __io_br();				\
+	 __v = __raw_readb(c);			\
+	 __io_ar();				\
+	 __v; })
 #endif
 
 #ifndef readw
 #define readw readw
-static inline u16 readw(const volatile void __iomem *addr)
-{
-	return __le16_to_cpu(__raw_readw(addr));
-}
+#define readw(c)				\
+    ({ u16 __v;					\
+						\
+     __io_br();					\
+      __v = __le16_to_cpu(__raw_readw(c));	\
+     __io_ar();					\
+     __v; })
 #endif
 
 #ifndef readl
 #define readl readl
-static inline u32 readl(const volatile void __iomem *addr)
-{
-	return __le32_to_cpu(__raw_readl(addr));
-}
+#define readl(c)				\
+    ({ u32 __v;					\
+						\
+     __io_br();					\
+      __v = __le32_to_cpu(__raw_readl(c));	\
+     __io_ar();					\
+     __v; })
 #endif
 
 #ifdef CONFIG_64BIT
 #ifndef readq
 #define readq readq
-static inline u64 readq(const volatile void __iomem *addr)
-{
-	return __le64_to_cpu(__raw_readq(addr));
-}
+#define readq(c)				\
+    ({ u64 __v;					\
+						\
+     __io_br();					\
+      __v = __le64_to_cpu(__raw_readq(c));	\
+     __io_ar();					\
+     __v; })
 #endif
 #endif /* CONFIG_64BIT */
  


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
