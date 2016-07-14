Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:53183 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751224AbcGNUaT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2016 16:30:19 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 01/32] bluetooth: Switch SMP to crypto_cipher_encrypt_one()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALCETrXYNM_b41J30eSuuhKtPRUANFpTh6bfuHM4-_RYGuZbZw@mail.gmail.com>
Date: Thu, 14 Jul 2016 21:30:15 +0100
Content-Transfer-Encoding: 8BIT
Message-ID: <4AED1BFF-7BBD-465C-B9F6-532B1B864346@holtmann.org>
References: <cover.1468270393.git.luto@kernel.org> <264af59a3060c2bc2a725cfc66a8fa68219d1c4a.1468270393.git.luto@kernel.org> <CALCETrXYNM_b41J30eSuuhKtPRUANFpTh6bfuHM4-_RYGuZbZw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, Network Development <netdev@vger.kernel.org>
Message-ID: <20160714203015.EwhpHXE7DUdXMav6IgxUemanudan0esEWdIfNiH8KdM@z>

Hi Andy,

>> SMP does ECB crypto on stack buffers.  This is complicated and
>> fragile, and it will not work if the stack is virtually allocated.
>> 
>> Switch to the crypto_cipher interface, which is simpler and safer.
> 
> Hi Dave-
> 
> It looks like we're delaying virtually mapped stacks to 4.9.  That
> means that there's time for this to go in through net-next.  Could you
> queue it up?

it is actually already in net-next since we decided to let git handle any potential merge issue.

Regards

Marcel

