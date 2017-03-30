From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 17:43:42 +0100
Message-ID: <20170330164342.GR29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <20170330162241.GG7909@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170330162241.GG7909@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwi>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 30, 2017 at 05:22:41PM +0100, Russell King - ARM Linux wrote:
> On Wed, Mar 29, 2017 at 06:57:06AM +0100, Al Viro wrote:
> > Comments, review, testing, replacement patches, etc. are very welcome.
> 
> I've given this a spin, and it appears to work (in that the box boots).
> 
> Kernel size wise:
> 
>    text    data      bss      dec     hex filename
> 8020229 3014220 10243276 21277725 144ac1d vmlinux.orig
> 8034741 3014388 10243276 21292405 144e575 vmlinux.uaccess
> 7976719 3014324 10243276 21234319 144028f vmlinux.noinline
> 
> Performance using hdparm -T (cached reads) to evaluate against a SSD
> gives me the following results:
> 
> * original:
>  Timing cached reads:   580 MB in  2.00 seconds = 289.64 MB/sec
>  Timing cached reads:   580 MB in  2.00 seconds = 290.06 MB/sec
>  Timing cached reads:   580 MB in  2.00 seconds = 289.65 MB/sec
>  Timing cached reads:   582 MB in  2.00 seconds = 290.82 MB/sec
>  Timing cached reads:   578 MB in  2.00 seconds = 289.07 MB/sec
> 
>  Average = 289.85MB/s
> 
> * uaccess:
>  Timing cached reads:   578 MB in  2.00 seconds = 288.36 MB/sec
>  Timing cached reads:   534 MB in  2.00 seconds = 266.68 MB/sec
>  Timing cached reads:   534 MB in  2.00 seconds = 267.07 MB/sec
>  Timing cached reads:   552 MB in  2.00 seconds = 275.45 MB/sec
>  Timing cached reads:   532 MB in  2.00 seconds = 266.08 MB/sec
> 
>  Average = 272.73 MB/sec
> 
> * noinline:
>  Timing cached reads:   548 MB in  2.00 seconds = 274.16 MB/sec
>  Timing cached reads:   574 MB in  2.00 seconds = 287.19 MB/sec
>  Timing cached reads:   574 MB in  2.00 seconds = 286.47 MB/sec
>  Timing cached reads:   572 MB in  2.00 seconds = 286.20 MB/sec
>  Timing cached reads:   578 MB in  2.00 seconds = 288.86 MB/sec
> 
>  Average = 284.58 MB/sec
> 
> I've run the test twice, and there's definitely a reproducable drop in
> performance for some reason when switching between current and Al's
> uaccess patches, which is partly recovered by switching to the out of
> line versions.
> 
> The only difference that I can identify that could explain this are
> the extra might_fault() checks in Al's version but which are missing
> from the ARM version.

How would the following affect things?

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e68604ae3ced..d24d338f0682 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -184,7 +184,7 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
 
 	kaddr = kmap(page);
 	from = kaddr + offset;
-	left = __copy_to_user(buf, from, copy);
+	left = __copy_to_user_inatomic(buf, from, copy);
 	copy -= left;
 	skip += copy;
 	from += copy;
@@ -193,7 +193,7 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
 		iov++;
 		buf = iov->iov_base;
 		copy = min(bytes, iov->iov_len);
-		left = __copy_to_user(buf, from, copy);
+		left = __copy_to_user_inatomic(buf, from, copy);
 		copy -= left;
 		skip = copy;
 		from += copy;
@@ -267,7 +267,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 
 	kaddr = kmap(page);
 	to = kaddr + offset;
-	left = __copy_from_user(to, buf, copy);
+	left = __copy_from_user_inatomic(to, buf, copy);
 	copy -= left;
 	skip += copy;
 	to += copy;
@@ -276,7 +276,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 		iov++;
 		buf = iov->iov_base;
 		copy = min(bytes, iov->iov_len);
-		left = __copy_from_user(to, buf, copy);
+		left = __copy_from_user_inatomic(to, buf, copy);
 		copy -= left;
 		skip = copy;
 		to += copy;
@@ -541,7 +541,7 @@ size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 	if (unlikely(i->type & ITER_PIPE))
 		return copy_pipe_to_iter(addr, bytes, i);
 	iterate_and_advance(i, bytes, v,
-		__copy_to_user(v.iov_base, (from += v.iov_len) - v.iov_len,
+		__copy_to_user_inatomic(v.iov_base, (from += v.iov_len) - v.iov_len,
 			       v.iov_len),
 		memcpy_to_page(v.bv_page, v.bv_offset,
 			       (from += v.bv_len) - v.bv_len, v.bv_len),
@@ -560,7 +560,7 @@ size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 		return 0;
 	}
 	iterate_and_advance(i, bytes, v,
-		__copy_from_user((to += v.iov_len) - v.iov_len, v.iov_base,
+		__copy_from_user_inatomic((to += v.iov_len) - v.iov_len, v.iov_base,
 				 v.iov_len),
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
@@ -582,7 +582,7 @@ bool copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 		return false;
 
 	iterate_all_kinds(i, bytes, v, ({
-		if (__copy_from_user((to += v.iov_len) - v.iov_len,
+		if (__copy_from_user_inatomic((to += v.iov_len) - v.iov_len,
 				      v.iov_base, v.iov_len))
 			return false;
 		0;}),
