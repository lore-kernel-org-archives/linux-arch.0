From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Mon, 8 Jan 2018 12:33:19 +0000
Message-ID: <f1fd4ae6fe284d9489ae5e2ceb344403@AcuMS.aculab.com>
References: <20180106123242.77f4d860@alans-desktop>
        <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
        <20180106183859.1ad9ae37@alans-desktop>
        <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
        <20180106195551.3207f75d@alans-desktop>
        <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
        <20180106202213.23e553fb@alans-desktop>
        <20180106211729.cp5oet3at3hyce4o@ast-mbp>
        <20180106230507.3547c9a0@alans-desktop>
        <20180107033812.awq3vz4gdkps7tix@ast-mbp>       <20180107063356.GA9425@1wt.eu>
        <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
        <138620e379794e98b606ed675da6d04d@AcuMS.aculab.com>
 <20180108121245.194360d4@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.195]:62307 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757044AbeAHMck (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jan 2018 07:32:40 -0500
In-Reply-To: <20180108121245.194360d4@alans-desktop>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Alan Cox' <gnomes@lxorguk.ukuu.org.uk>
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

From: Alan Cox
> Sent: 08 January 2018 12:13
...
> > Try over 35% slowdown....
> > Given that AWS instance runs known code (user and kernel) why do we
> > need to worry about any of these sideband attacks?
> 
> You may not need to. Amazon themselves obviously need to worry that no
> other VM steals your data (or vice versa) but above that (and with raw
> hardware appliances) if you control all the code you run then the nopti
> and other disables may be useful (At the end of the day as with anything
> else you do your own risk assessment).

I believe AWS allows VM kernels to load user-written device drivers
so the security of other VMs cannot rely on whether a VM is booted
with PTI=yes or PTI=no.

	David
