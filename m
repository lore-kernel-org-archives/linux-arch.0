From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH v4 6/7] uapi: export all headers under uapi directories
Date: Mon, 23 Jan 2017 17:03:04 +0100
Message-ID: <ab8be0a4-a89a-e2d9-2a55-0901e792f8a5@6wind.com>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-7-git-send-email-nicolas.dichtel@6wind.com>
 <20170123152508.GA12899@infradead.org>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170123152508.GA12899@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, tklauser@distanz.ch, mpe@ellerman.id.au
List-Id: linux-arch.vger.kernel.org

Le 23/01/2017 à 16:25, Christoph Hellwig a écrit :
>> .install
> 
>> linux/genwqe/.install
>> linux/genwqe/..install.cmd
> 
> ...
> 
> If these aren't just a mistake in your list the patches need to be
> fixed not to install this build system internal file.
> 
> And I'm pretty sure I already pointed this out last time.
> 
Yes, it was already pointed out. But, as I said, this is done for *every*
exported directory. My patch just follows how it is done currently:
$ find . -name '.install' | wc -l
105
$ find . -name '..install.cmd' | wc -l
105
$ find . -type d | wc -l
105

I'm not against removing these files, but this should be done in another patch,
it's not related to this series.
Fell free to send a patch.


Regards,
Nicolas
