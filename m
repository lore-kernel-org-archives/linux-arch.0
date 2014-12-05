Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:49009 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750800AbaLEMJD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Dec 2014 07:09:03 -0500
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 16562-04 for <linux-arch@vger.kernel.org>;
 Fri,  5 Dec 2014 12:08:54 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v1 3/5] mm, uaccess: trigger might_sleep() in
 might_fault() when pagefaults are disabled
Date: Fri, 5 Dec 2014 12:08:19 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CA035A5@AcuExch.aculab.com>
References: <1417778289-51567-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1417778289-51567-4-git-send-email-dahi@linux.vnet.ibm.com>
	<20141205114529.GD4213@osiris> <20141205124629.2c77290f@thinkpad-w530>
In-Reply-To: <20141205124629.2c77290f@thinkpad-w530>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'David Hildenbrand' <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org" <peterz@infradead.org>, "hughd@google.com" <hughd@google.com>, "hocko@suse.cz" <hocko@suse.cz>
Message-ID: <20141205120819.arv1yqgQUavEeScemL3FAqf4976nYDDBN7UnxA2gorw@z>

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
