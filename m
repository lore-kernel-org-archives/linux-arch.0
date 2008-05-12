From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCHv2] Make for_each_cpu_mask a bit smaller
Date: Mon, 12 May 2008 23:45:42 +0200
Message-ID: <jeej8742nt.fsf@sykes.suse.de>
References: <20080511135039.GA3286@mailshack.com>
	<20080511091403.a75f5b78.pj@sgi.com>
	<20080511160658.GA3398@mailshack.com>
	<20080511160104.c3fef6bf.pj@sgi.com>
	<1210593896.23716.1252664185@webmail.messagingengine.com>
	<4828741B.2080802@sgi.com> <20080512190039.GA13324@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44378 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbYELVpo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 May 2008 17:45:44 -0400
In-Reply-To: <20080512190039.GA13324@mailshack.com> (Alexander van Heukelum's
	message of "Mon, 12 May 2008 21:00:39 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: Mike Travis <travis@sgi.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Paul Jackson <pj@sgi.com>, Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>, ARCH <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexander van Heukelum <heukelum@fastmail.fm>

Alexander van Heukelum <heukelum@mailshack.com> writes:

> +#define for_each_cpu_mask(cpu, mask)			\
> +	for ((cpu) =3D ~((typeof(cpu))0);			\

There is no need for such a complicated expression, -1 will work for
every (arithmetic) type.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
