From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 00/47] Sparse irq rework
Date: Thu, 30 Sep 2010 20:32:26 -0700
Message-ID: <AANLkTin1titZ1vjGLhBn8CY0CjZDj332zM8DW1JHv7Cx@mail.gmail.com>
References: <20100930221351.682772535@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100930221351.682772535@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 30, 2010 at 4:14 PM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
>
> The overall changes are (full changelog below):
> =A0 =A056 files changed, 1229 insertions(+), 1682 deletions(-)

I can't really argue with those numbers. And the patches I looked at
(which was not all of them, but maybe half) looked reasonable.

Assuming it all _works_ ...

                Linus
