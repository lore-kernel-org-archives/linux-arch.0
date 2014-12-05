From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v1 3/5] mm, uaccess: trigger might_sleep() in
 might_fault() when pagefaults are disabled
Date: Fri, 5 Dec 2014 12:08:19 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CA035A5@AcuExch.aculab.com>
References: <1417778289-51567-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1417778289-51567-4-git-send-email-dahi@linux.vnet.ibm.com>
	<20141205114529.GD4213@osiris> <20141205124629.2c77290f@thinkpad-w530>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141205124629.2c77290f@thinkpad-w530>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'David Hildenbrand' <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org" <peterz@infradead.org>, "hughd@google.com" <hughd@google.com>, "hocko@suse.cz" <hocko@suse.cz>
List-Id: linux-arch.vger.kernel.org

From: David Hildenbrand [...
> > This should be likely() instead of unlikely(), no?
> > I'd rather write this
> >
> > 	if (pagefault_disabled())
> >  		return;
> > 	__might_sleep(file, line, 0);
> >
> > and leave the likely stuff completely away.
> 
> Makes perfect sense!

From my experience of getting (an older version of) gcc to emit
'correctly' statically predicted branches I found that code that
looks like (I don't think return/goto make any difference):

	If (unlikely(condition)) {
		code;
	}
	more_code;

is compile with a forwards conditional branch (ie ignoring the unlikely()).
Similarly 'if () continue' is likely to generate a 'predicted taken'
backwards conditional branch.

To get the desired effect you need a non-empty 'else' part, an assembler
comment will suffice, eg: asm volatile("# comment").

	David
