From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
Date: Wed, 11 Mar 2020 10:09:54 +0100
Message-ID: <5546ac4d-b9d1-336e-3861-b1f37e1d059c@vivier.eu>
References: <20200306080905.173466-1-syq@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200306080905.173466-1-syq@debian.org>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: YunQiang Su <syq@debian.org>, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, James.Bottomley@hansenpartnership.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
List-Id: linux-arch.vger.kernel.org

Le 06/03/2020 à 09:09, YunQiang Su a écrit :
> From: Laurent Vivier <laurent@vivier.eu>
> 
> It can be useful to the interpreter to know which flags are in use.
> 
> For instance, knowing if the preserve-argv[0] is in use would
> allow to skip the pathname argument.
> 
> This patch uses an unused auxiliary vector, AT_FLAGS, to add a
> flag to inform interpreter if the preserve-argv[0] is enabled.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: YunQiang Su <syq@debian.org>
> ---

Any advice to have this merged?

Do I really need to use another AT_ entry?

Thanks,
Laurent
