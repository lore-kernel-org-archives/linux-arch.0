From: "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: Re: [RFC][PATCH] MIPS: VPE: Remove vpe_getuid and vpe_getgid
Date: Tue, 21 Jan 2014 14:29:05 -0600
Message-ID: <52DED891.60301@imgtec.com>
References: <8738kh6usi.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:63080 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbaAUU33 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jan 2014 15:29:29 -0500
In-Reply-To: <8738kh6usi.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Deng-Cheng Zhu <Dengcheng.Zhu@imgtec.com>

On 01/21/2014 12:42 PM, Eric W. Biederman wrote:
>
> The linux build-bot recently reported a build error in arch/mips/kernel/vpe.c
>
>       tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus
>       head:   261000a56b6382f597bcb12000f55c9ff26a1efb
>       commit: 261000a56b6382f597bcb12000f55c9ff26a1efb [4/4] userns:  userns: Remove UIDGID_STRICT_TYPE_CHECKS
>       config: make ARCH=mips maltaaprp_defconfig
>
>       All error/warnings:
>
>          arch/mips/kernel/vpe.c: In function 'vpe_open':
>       >> arch/mips/kernel/vpe.c:1086:9: error: incompatible types when assigning to type 'unsigned int' from type 'kuid_t'
>       >> arch/mips/kernel/vpe.c:1087:9: error: incompatible types when assigning to type 'unsigned int' from type 'kgid_t'
>
>       vim +1086 arch/mips/kernel/vpe.c
>
>       863abad4 Jesper Juhl   2010-10-30  1080			return -ENOMEM;
>       863abad4 Jesper Juhl   2010-10-30  1081  		}
>       e01402b1 Ralf Baechle  2005-07-14  1082  		v->plen = P_SIZE;
>       e01402b1 Ralf Baechle  2005-07-14  1083  		v->load_addr = NULL;
>       e01402b1 Ralf Baechle  2005-07-14  1084  		v->len = 0;
>       e01402b1 Ralf Baechle  2005-07-14  1085
>       d76b0d9b David Howells 2008-11-14 @1086		v->uid = filp->f_cred->fsuid;
>       d76b0d9b David Howells 2008-11-14 @1087  		v->gid = filp->f_cred->fsgid;
>       2600990e Ralf Baechle  2006-04-05  1088
>       2600990e Ralf Baechle  2006-04-05  1089		v->cwd[0] = 0;
>       2600990e Ralf Baechle  2006-04-05  1090 	 	ret = getcwd(v->cwd, VPE_PATH_MAX);
>
> When examining the code to see what v->uid and v->gid were used for I
> discovered that the only users in the kernel are vpe_getuid and
> vpe_getgid, and that vpe_getuid and vpe_getgid are never called.
>
> So instead of proposing a conversion to use kuid_t and kgid_t instead
> of unsigned int/int as I normally would let's just kill this dead code
> so no one has to worry about it further.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
This patch looks good to me, however, Deng-Cheng should also confirm if 
this patch is okay. He is currently maintaining that code. Thanks.

Steve
