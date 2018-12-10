Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:51150 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbeLJXdJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Dec 2018 18:33:09 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990694AbeLJXcqG0UdG (ORCPT
        <rfc822;linux-arch@vger.kernel.org> + 2 others);
        Tue, 11 Dec 2018 00:32:46 +0100
Date: Mon, 10 Dec 2018 23:32:46 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to
 'n64'
In-Reply-To: <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
Message-ID: <alpine.LFD.2.21.1812102324500.11202@eddie.linux-mips.org>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org> <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: Firoz Khan <firoz.khan@linaro.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Message-ID: <20181210233246.5HHHPVy7bA7gikWTCec-JfDaO0g87FjRyVUrUsG-AKw@z>

On Mon, 10 Dec 2018, Paul Burton wrote:

> And I realise that undoing that but keeping n64 in our own filenames &
> macros is another type of inconsistency, but something imperfect is
> unavoidable at this point given that the engineers way back when decided
> to use "ABI64" for n64.

 My feeling has been n32 was invented at SGI as an afterthought, hence the 
choice of having ABI32 or ABI64 defined for the 32-bit (now o32) and the 
64-bit (now n64) ABI respectively was reasonable.

 FWIW,

  Maciej
