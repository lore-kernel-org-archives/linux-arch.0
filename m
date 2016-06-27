Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:57660 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750884AbcF0F6o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2016 01:58:44 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 01/29] bluetooth: Switch SMP to crypto_cipher_encrypt_one()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <264af59a3060c2bc2a725cfc66a8fa68219d1c4a.1466974736.git.luto@kernel.org>
Date: Mon, 27 Jun 2016 07:58:33 +0200
Content-Transfer-Encoding: 8BIT
Message-ID: <8C5360E3-94EE-4869-B9B9-AF9D41B5A3AC@holtmann.org>
References: <cover.1466974736.git.luto@kernel.org> <cover.1466974736.git.luto@kernel.org> <264af59a3060c2bc2a725cfc66a8fa68219d1c4a.1466974736.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <20160627055833.t1ptNsB2Q2HzbAVRkYBSYQViECJT6dlqc_rTfv2pFf0@z>

Hi Andy,

> SMP does ECB crypto on stack buffers.  This is complicated and
> fragile, and it will not work if the stack is virtually allocated.
> 
> Switch to the crypto_cipher interface, which is simpler and safer.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> Acked-and-tested-by: Johan Hedberg <johan.hedberg@intel.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> net/bluetooth/smp.c | 67 ++++++++++++++++++++++-------------------------------
> 1 file changed, 28 insertions(+), 39 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

