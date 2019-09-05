Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52743 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbfIEK74 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Sep 2019 06:59:56 -0400
Subject: Re: [PATCH v8 06/28] x86/asm/crypto: annotate local functions
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-7-jslaby@suse.cz> <20190817091733.GB15364@zn.tnic>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <400845b5-d9a9-3db1-b3a5-bb0cfddc9237@suse.cz>
Date: Thu, 5 Sep 2019 12:59:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190817091733.GB15364@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Message-ID: <20190905105950.wdlI2-BE-6Zr-EDGhUh8mgzYL-7IB-s-SXs5nS3ZeF4@z>

On 17. 08. 19, 11:17, Borislav Petkov wrote:
> On Thu, Aug 08, 2019 at 12:38:32PM +0200, Jiri Slaby wrote:
>> Use the newly added SYM_FUNC_START_LOCAL to annotate starts of all
>> functions which do not have ".globl" annotation, but their ends are
>> annotated by ENDPROC. This is needed to balance ENDPROC for tools that
>> generate debuginfo.
>>
>> To be symmetric, we also convert their ENDPROCs to the new SYM_FUNC_END.
> 
> All those functions look like they could be made local symbols by
> prepending their names with ".L" so that they disappear from the
> vmlinux symtable too.

In that case, objtool won't see them and won't generate ORC info for
them. That means not only they disappear from stacktraces, but it will
be disallowed to unwind below them. Note that objtool currently reads
symtables and looks for STT_FUNC in them.

We can make them local (.L*) when the patchset is applied and all
functions are annotated properly -- then we won't need entries in the
global symtable. We can store the info in some private table and delete
it after objtool is done with the object.

thanks,
-- 
js
suse labs
