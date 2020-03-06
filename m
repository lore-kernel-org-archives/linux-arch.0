From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
Date: Fri, 06 Mar 2020 09:13:50 +0100
Message-ID: <87r1y53npd.fsf@mid.deneb.enyo.de>
References: <20200306080905.173466-1-syq@debian.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200306080905.173466-1-syq@debian.org> (YunQiang Su's message
        of "Fri, 6 Mar 2020 16:09:05 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: YunQiang Su <syq@debian.org>
Cc: torvalds@linux-foundation.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, James.Bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org, Laurent Vivier <laurent@vivier.eu>
List-Id: linux-arch.vger.kernel.org

* YunQiang Su:

> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
> +	NEW_AUX_ENT(AT_FLAGS, flags);

Is it necessary to reuse AT_FLAGS?  I think it's cleaner to define a
separate AT_ tag dedicated to binfmt_misc.
