From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
Date: Fri, 6 Mar 2020 09:21:46 +0100
Message-ID: <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu>
References: <20200306080905.173466-1-syq@debian.org>
 <87r1y53npd.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:56543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgCFIWD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 03:22:03 -0500
In-Reply-To: <87r1y53npd.fsf@mid.deneb.enyo.de>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fw@deneb.enyo.de>, YunQiang Su <syq@debian.org>
Cc: torvalds@linux-foundation.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, James.Bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org

Le 06/03/2020 à 09:13, Florian Weimer a écrit :
> * YunQiang Su:
> 
>> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
>> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
>> +	NEW_AUX_ENT(AT_FLAGS, flags);
> 
> Is it necessary to reuse AT_FLAGS?  I think it's cleaner to define a
> separate AT_ tag dedicated to binfmt_misc.
> 

Not necessary, but it seemed simpler and cleaner to re-use a flag that
is marked as unused and with a name matching the new role. It avoids to
patch other packages (like glibc) to add it as it is already defined.

Thanks,
Laurent
