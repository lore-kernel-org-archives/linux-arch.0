Return-Path: <SRS0=ZCnS=4X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from albireo.enyo.de ([37.24.231.21]:54568 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgCFIVh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 03:21:37 -0500
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
References: <20200306080905.173466-1-syq@debian.org>
Date: Fri, 06 Mar 2020 09:13:50 +0100
In-Reply-To: <20200306080905.173466-1-syq@debian.org> (YunQiang Su's message
        of "Fri, 6 Mar 2020 16:09:05 +0800")
Message-ID: <87r1y53npd.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: YunQiang Su <syq@debian.org>
Cc: torvalds@linux-foundation.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, James.Bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org, Laurent Vivier <laurent@vivier.eu>
Message-ID: <20200306081350.0EwGMW6ir34d-pv2ssYyCHuLHAJcFWRaFYS9c6VE5IU@z>

* YunQiang Su:

> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
> +	NEW_AUX_ENT(AT_FLAGS, flags);

Is it necessary to reuse AT_FLAGS?  I think it's cleaner to define a
separate AT_ tag dedicated to binfmt_misc.
