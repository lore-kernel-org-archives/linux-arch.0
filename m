From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 00/21] mm: Preemptibility -v6
Date: Tue, 18 Jan 2011 11:30:47 +0100
Message-ID: <1295346647.30950.477.camel@laptop>
References: <20101126143843.801484792@chello.nl>
	 <alpine.LSU.2.00.1101172301340.2899@sister.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.LSU.2.00.1101172301340.2899@sister.anvils>
Sender: owner-linux-mm@kvack.org
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Nick Piggin <npiggin@kernel.dk>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Mon, 2011-01-17 at 23:12 -0800, Hugh Dickins wrote:
> I understand you're intending to update your preemptible mmu_gather
> patchset against 2.6.38-rc1, so I've spent a while looking through
> (and running) your last posted version (plus its two fixes from BenH).
>=20
> I've had no problems in running it, I can't tell if it's quicker or
> slower than the unpatched.  The only argument against the patchset,
> really, would be performance: and though there are no bad reports on
> it as yet, I do wonder how we proceed if a genuine workload shows up
> which is adversely affected.  Oh well, silly to worry about the
> hypothetical I suppose.
>=20
Wow, _HUGE_ review, thanks! I'll slowly make my way through it when I do
the rebase against .38-rc1, most suggestions look very good indeed.

And as to performance, there's the no-regression report from Yanmin
running it through the Intel test farm. However Nick also had a
particular workload he wanted to test, Nick, do you think you've got a
few spare minutes to dig that workload up and give it a run?

But I guess you're right, there's always a chance someone hits
something, and I guess there's nothing to it but to deal with it when
that comes..

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom policy in Canada: sign http://dissolvethecrtc.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
