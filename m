From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 0/2] fun with tlb flushing on s390
Date: Fri, 27 Jul 2012 10:01:31 +0200
Message-ID: <1343376091.32120.23.camel@twins>
References: <1343317634-13197-1-git-send-email-schwidefsky@de.ibm.com>
	 <1343331770.32120.6.camel@twins> <20120727085718.19c33cce@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20120727085718.19c33cce@de.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, Zachary Amsden <zach@vmware.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Fri, 2012-07-27 at 08:57 +0200, Martin Schwidefsky wrote:
> > > powerpc=20
> >=20
> > I have a patch that makes sparc64 do the same thing.
>=20
> That is good, I guess we are in agreement then to add the mm
> argument.=20

Ah, what I meant was make sparc64 use the lazy_mmu stuff just like ppc64
does. I haven't so far had a need for extra arguments.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
