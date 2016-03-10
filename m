From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Thu, 10 Mar 2016 07:44:06 +0000
Message-ID: <1457595846.2868.10.camel@synopsys.com>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
	 <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:37757 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932742AbcCJHoM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2016 02:44:12 -0500
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
Content-Language: en-US
Content-ID: <B18BC8B5E0A9F44AA0C96D51346FDDA7@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "noamc@ezchip.com" <noamc@ezchip.com>, Lada Trimasova <Lada.Trimasova@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

Hi Vineet,

On Thu, 2016-03-10 at 05:05 +-0000, Vineet Gupta wrote:
+AD4- +-CC Noam
+AD4- 
+AD4- On Wednesday 09 March 2016 10:51 PM, Lada Trimasova wrote:
+AD4- +AD4- 
+AD4- +AD4- Memory access primitives should use cpu+AF8-to+AF8-le16, cpu+AF8-to+AF8-le32, le16+AF8-to+AF8-cpu
+AD4- +AD4- and le32+AF8-to+AF8-cpu because it is not really guaranteed that drivers handles
+AD4- +AD4- any ordering themselves.
+AD4- That is the driver issue. readxx as API simply returns data in native endianness.
+AD4- We've had EZChip running big endian and so far and they didn't need this change.

Let me disagree with you here.
See what is said in +ACI-include/asm-generic/io.h+ACI-:
----------------------+AD4-8---------------------
/+ACo-
+AKAAKg- +AF8AXw-raw+AF8Aew-read,write+AH0Aew-b,w,l,q+AH0-() access memory in native endianness.
+AKAAKg-
+AKAAKg- On some architectures memory mapped IO needs to be accessed differently.
+AKAAKg- On the simple architectures, we just read/write the memory location
+AKAAKg- directly.
+AKAAKg-/

...

/+ACo-
+AKAAKg- +AHs-read,write+AH0Aew-b,w,l,q+AH0-() access little endian memory and return result in
+AKAAKg- native endianness.
+AKAAKg-/
----------------------+AD4-8---------------------

And that's an implementation we have for ARC:
----------------------+AD4-8---------------------
+ACM-define readb(c)		(+AHs- u8+AKAAoABfAF8-v +AD0- readb+AF8-relaxed(c)+ADs- +AF8AXw-iormb()+ADs- +AF8AXw-v+ADs- +AH0-)
+ACM-define readw(c)		(+AHs- u16 +AF8AXw-v +AD0- readw+AF8-relaxed(c)+ADs- +AF8AXw-iormb()+ADs- +AF8AXw-v+ADs- +AH0-)
+ACM-define readl(c)		(+AHs- u32 +AF8AXw-v +AD0- readl+AF8-relaxed(c)+ADs- +AF8AXw-iormb()+ADs- +AF8AXw-v+ADs- +AH0-)

+ACM-define writeb(v,c)		(+AHs- +AF8AXw-iowmb()+ADs- writeb+AF8-relaxed(v,c)+ADs- +AH0-)
+ACM-define writew(v,c)		(+AHs- +AF8AXw-iowmb()+ADs- writew+AF8-relaxed(v,c)+ADs- +AH0-)
+ACM-define writel(v,c)		(+AHs- +AF8AXw-iowmb()+ADs- writel+AF8-relaxed(v,c)+ADs- +AH0-)

/+ACo-
+AKAAKg- Relaxed API for drivers which can handle any ordering themselves
+AKAAKg-/
+ACM-define readb+AF8-relaxed(c)	+AF8AXw-raw+AF8-readb(c)
+ACM-define readw+AF8-relaxed(c)	+AF8AXw-raw+AF8-readw(c)
+ACM-define readl+AF8-relaxed(c)	+AF8AXw-raw+AF8-readl(c)

+ACM-define writeb+AF8-relaxed(v,c)	+AF8AXw-raw+AF8-writeb(v,c)
+ACM-define writew+AF8-relaxed(v,c)	+AF8AXw-raw+AF8-writew(v,c)
+ACM-define writel+AF8-relaxed(v,c)	+AF8AXw-raw+AF8-writel(v,c)
----------------------+AD4-8---------------------

Which is effectively (related to endianess discussion):
----------------------+AD4-8---------------------
+ACM-define readX(c)	+AF8AXw-raw+AF8-readX(c)
+ACM-define writeX(v,c)	+AF8AXw-raw+AF8-writeX(v,c)
----------------------+AD4-8---------------------

That looks IMHO incorrect if we read API description in +ACI-include/asm-generic/io.h+ACI-.
BTW description of +AHs-read,write+AH0Aew-b,w,l,q+AH0-() is a bit misleading in part saying
+ACI-... and return result in +AF8AXw-native+AF8-endianness+AF8AXwAi-.

But real implementation of +AHs-read,write+AH0Aew-b,w,l,q+AH0-() in +ACI-include/asm-generic/io.h+ACI-
really shows what was meant - note+AKAAXwBf-leXX+AF8-to+AF8-cpu() and+AKA-cpu+AF8-to+AF8-leXX are used.

+AD4- +AD4- 
+AD4- +AD4- For example, serial port driver doesn't work when kernel is build for
+AD4- +AD4- arc big endian architecture.
+AD4- Last I tested Big Endian on SDP with 8250 part +- 8250 driver it was working fine.
+AD4- I presume this is the systemC model for device and standard 8250 driver and very
+AD4- likely the model is not fixed endian or something.

Model is indeed little-endian. We build it only once and than changing
only +ACI-nsim+AF8-isa+AF8-big+AF8-endian+ACI- property (which changes only CPU core endianess) may use
it equally well with little- and big-endian builds of Linux kernel.

-Alexey