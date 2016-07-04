Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:60799 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752314AbcGDR4F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2016 13:56:05 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 01/29] bluetooth: Switch SMP to crypto_cipher_encrypt_one()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALCETrVx6PDUb+5S9eYuB+Dhu2VEkz-iz=hpRJdzxRfXypwK8A@mail.gmail.com>
Date: Mon, 4 Jul 2016 19:56:00 +0200
Content-Transfer-Encoding: 8BIT
Message-ID: <73C272C5-ECDB-4508-B8D3-1F54D5E8E6AB@holtmann.org>
References: <cover.1466974736.git.luto@kernel.org> <264af59a3060c2bc2a725cfc66a8fa68219d1c4a.1466974736.git.luto@kernel.org> <8C5360E3-94EE-4869-B9B9-AF9D41B5A3AC@holtmann.org> <20160627085403.GA26865@gmail.com> <2833CC26-7306-4803-A5DB-4CBECCF35C08@holtmann.org> <CALCETrVx6PDUb+5S9eYuB+Dhu2VEkz-iz=hpRJdzxRfXypwK8A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, Network Development <netdev@vger.kernel.org>
Message-ID: <20160704175600.jBZnAvuGijHNy52x28Byl5UsSG-wTbVJ3GMbvZbYoKs@z>

Hi Andy,

>>>>> SMP does ECB crypto on stack buffers.  This is complicated and
>>>>> fragile, and it will not work if the stack is virtually allocated.
>>>>> 
>>>>> Switch to the crypto_cipher interface, which is simpler and safer.
>>>>> 
>>>>> Cc: Marcel Holtmann <marcel@holtmann.org>
>>>>> Cc: Gustavo Padovan <gustavo@padovan.org>
>>>>> Cc: Johan Hedberg <johan.hedberg@gmail.com>
>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>> Cc: linux-bluetooth@vger.kernel.org
>>>>> Cc: netdev@vger.kernel.org
>>>>> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
>>>>> Acked-and-tested-by: Johan Hedberg <johan.hedberg@intel.com>
>>>>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>>>>> ---
>>>>> net/bluetooth/smp.c | 67 ++++++++++++++++++++++-------------------------------
>>>>> 1 file changed, 28 insertions(+), 39 deletions(-)
>>>> 
>>>> patch has been applied to bluetooth-next tree.
>>> 
>>> Sadly carrying this separately will delay the virtual kernel stacks feature by a
>>> kernel cycle, because it's a must-have prerequisite.
>> 
>> I can take it back out, but then I have the fear the the ECDH change to use KPP for SMP might be the one that has to wait a kernel cycle. Either way is fine with me, but I want to avoid nasty merge conflicts in the Bluetooth SMP code.
> 
> Nothing goes wrong if an identical patch is queued in both places,
> right?  Or, if you prefer not to duplicate it, could one of you commit
> it and the other one pull it?  Ingo, given that this is patch 1 in the
> series and unlikely to change, if you want to make this whole thing
> have a separate branch in -tip, this could live there for starters.
> (But, if you do so, please make sure you base off a very new copy of
> Linus' tree -- the series is heavily dependent on the thread_info
> change he applied a few days ago.)

so what are doing now? I take this back out or we keep it in and let git deal with it when merging the trees?

Regards

Marcel

