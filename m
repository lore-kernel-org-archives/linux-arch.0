Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbdASLUF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2017 06:20:05 -0500
Date: Thu, 19 Jan 2017 12:20:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 08/14] jump_label: move guard #endif down where it
 belongs
Message-ID: <20170119112017.GM28024@kroah.com>
References: <20170109145833.11502-1-mcgrof@kernel.org>
 <20170115211057.17167-1-mcgrof@kernel.org>
 <20170115211057.17167-9-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170115211057.17167-9-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: bp@alien8.de, bp@suse.de, hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, linux@roeck-us.net, torvalds@linux-foundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, adrian.hunter@intel.com, dsahern@gmail.com, namhyung@kernel.org, wangnan0@huawei.com, dmitry.torokhov@gmail.com, joro@8bytes.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com
Message-ID: <20170119112017.9OQMMTpcYXEgY0R40zLGTQeus12-Xiyjd4LvAy0CUho@z>

On Sun, Jan 15, 2017 at 01:10:51PM -0800, Luis R. Rodriguez wrote:
> The ending header guard is misplaced. This has no
> functional change, this is just an eye-sore.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  include/linux/jump_label.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index a0547c571800..b63d6b7b0db0 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -402,6 +402,6 @@ extern bool ____wrong_branch_error(void);
>  #define static_branch_enable(x)		static_key_enable(&(x)->key)
>  #define static_branch_disable(x)	static_key_disable(&(x)->key)
>  
> -#endif	/* _LINUX_JUMP_LABEL_H */
> -
>  #endif /* __ASSEMBLY__ */
> +
> +#endif	/* _LINUX_JUMP_LABEL_H */
> -- 
> 2.11.0

Why is this in this patch series?
