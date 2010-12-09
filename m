Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49973 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab0LISXd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Dec 2010 13:23:33 -0500
MIME-Version: 1.0
In-Reply-To: <20101209131452.GA2260@a1.tnic>
References: <AANLkTin7xDWO8fU2WA7cxC55TNi2+kAb50ajCySCfg9G@mail.gmail.com>
	<4d00164c296166b682@agluck-desktop.sc.intel.com>
	<20101209131452.GA2260@a1.tnic>
Date: Thu, 9 Dec 2010 10:23:32 -0800
Message-ID: <AANLkTimWT8=fmqbEeb+qXbwsWOmaz5d2_Bsr-=DON7L1@mail.gmail.com>
Subject: Re: [RFC] persistent store (version 3) (part 1 of 2)
From: Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, greg@kroah.com, akpm@linux-foundation.org, ying.huang@intel.com, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Keniston <jkenisto@linux.vnet.ibm.com>, Kyungmin Park <kmpark@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20101209182332.Uz0gnVvI2MgRDV1P4i3bZRvzIb9XbJrovn-7O13Z2YY@z>

On Thu, Dec 9, 2010 at 5:14 AM, Borislav Petkov <bp@alien8.de> wrote:
>>       if (!pstore_writefile(inode, dentry, data, size)) {
>>               inode->i_nlink--;
>>               mutex_lock(&root->d_inode->i_mutex);
>>               d_delete(dentry);
>>               dput(dentry);
>>               mutex_unlock(&root->d_inode->i_mutex);
>>               rc = -ENOSPC;
>>               goto fail;
>>       }
>
> don't we have to iput() the inode here too if pstore_writefile() fails?

No. d_delete() called iput() for us (passing through
dentry_iput along the way) - so we must not do it again.
This upsets the traditional layout of having the error
recovery part of the function undo all the things that
we did leading up to the error. Pity, because your
version is easier to read.

-Tony
