From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v2] kdump: Fix crash_kexec - smp_send_stop race in panic
Date: Wed, 2 Nov 2011 13:57:26 -0700
Message-ID: <987664A83D2D224EAE907B061CE93D5301F527F980@orsmsx505.amr.corp.intel.com>
References: <1319639649.3321.11.camel@br98xy6r>
	 <20111028161143.e5ebf617.akpm@linux-foundation.org>
	 <1320055036.2796.8.camel@br98xy6r>
	 <20111031033948.a0edb7f3.akpm@linux-foundation.org>
	 <1320064459.2796.26.camel@br98xy6r> <20111101200420.GN17705@redhat.com>
 <1320228239.2776.14.camel@br98xy6r>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12243 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab1KBU5a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2011 16:57:30 -0400
In-Reply-To: <1320228239.2776.14.camel@br98xy6r>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>, Don Zickus <dzickus@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

> Instead of introducing the panic lock, as an alternative we could move
> smp_send_stop() to the beginning of panic(). Eric told me that the
> function is currently "insufficiently reliable" for that, but perhaps we
> could make it more reliable.

That's tough to do.  We are in panic because something went horribly
wrong somewhere in the kernel - so we can make few assumptions about
which subsystems are still working. In the worst case (for this example)
our panic was caused by a failure in the code that sends cross-processor
interrupts ... so calling that same code to stop the other cpus is
likely to run into the same problem - perhaps causing a nested panic.

So what looks like a good fix for some panic scenarios actually makes
others worse.

-Tony
