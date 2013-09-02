From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] Kconfig.debug: Add FRAME_POINTER anti-dependency for
 ARC
Date: Mon, 2 Sep 2013 14:18:45 +0530
Message-ID: <522450ED.1020704@synopsys.com>
References: <1377592285-21148-1-git-send-email-vgupta@synopsys.com> <521F662F.4050003@intel.com> <52204E4D.3030602@synopsys.com> <5220B83A.6070709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5220B83A.6070709@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paul.mckenney@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Michel Lespinasse <walken@google.com>, "David S. Miller" <davem@davemloft.net>, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Chris Metcalf <cmetcalf@tilera.com>
List-Id: linux-arch.vger.kernel.org

On 08/30/2013 08:50 PM, Dave Hansen wrote:
> On 08/30/2013 12:48 AM, Vineet Gupta wrote:
>> If we had ARCH_FRAME_POINTER_UNAVAILABLE (def_bool n), we could potentially remove
>> ARCH_FRAME_POINTER too:

>> The issue is some (sparc, c6x...) which are neither in #1 or #2, and not present
>> in anti-dependency list either. e.g. With sparc64_defconfig FP is not present, but
>> if I enable LATENCY_TOP, FP is enabled. For such cases, what do we make default ?
> 
> You can list multiple defaults if you want, or have them depend on other
> config variables:
> 
> config FOO
> 	default BAR
> 
> or
> 
> config FOO
> 	default y if BAR
> 	default n if BAZ
> 
> ARCH_FRAME_POINTER_UNAVAILABLE doesn't make much sense if
> FRAME_POINTER=n, right?  You can have it just plain depend on
> FRAME_POINTER, I think.


I think I was not very clear with the problem description.

With a defbool 'n', FP will be by default enabled and arches not interested in FP
will select ARCH_FRAME_POINTER_UNAVAILABLE. e.g. SPARC, so far so good.

That however means that LATENCYTOP enabled in sparc64_defconfig will now build
with !FP, whereas as of today it enables FP (and SPARC code must be OK with FP
enabling in this config). So, we are changing semantics here, which might still be
OK, but I'll only trust arch maintainers' NOD. So the change is not just
mechanical from that perspective.

My point is, before I cook the patch-set we must be in agreement to this
semantical change.

-Vineet
