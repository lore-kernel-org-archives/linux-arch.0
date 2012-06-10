Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:55326 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab2FJQgS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 10 Jun 2012 12:36:18 -0400
Received: by qcro28 with SMTP id o28so27304qcr.19
        for <linux-arch@vger.kernel.org>; Sun, 10 Jun 2012 09:36:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1338220457.git.rubini@gnudd.com>
References: <cover.1338220457.git.rubini@gnudd.com>
Date: Sun, 10 Jun 2012 18:36:17 +0200
Message-ID: <CACRpkdbPtR5MDjd1YZ5GhOdp61HQe2PJusudNPOhDQHUAt1kJA@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] Bridging PCI to amba
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alessandro Rubini <rubini@gnudd.com>
Cc: linux-kernel@vger.kernel.org, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Alan Cox <alan@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120610163617.fSYpdSYsvn9utwaP2sHg5tEAb6nOf2oOVI6EGMyTaOQ@z>

On Mon, May 28, 2012 at 6:36 PM, Alessandro Rubini <rubini@gnudd.com> wrote:

> V2: accepted comments I got on V1; rewritten the driver to be generic;
>    made it tristate instead of boolean. Rebased on new next.

This looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think this patch set could go through Arnd as arch maintainer?
It's fun with these cross-arch things. You'll need an ACK from
Russell first.

Yours,
Linus Walleij
