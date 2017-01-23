From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Mon, 23 Jan 2017 23:24:02 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701232316180.19605@erq.vanv.qr>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com> <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com> <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com> <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
 <d105332c-d8dd-938a-aaa5-ceb42fca4507@6wind.com> <20170123171732.i3qfbcsqzznppe5m@pd.tnic> <20170123172103.GB28446@infradead.org> <20170123172627.32zcbntwo7nmd5rf@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20170123172627.32zcbntwo7nmd5rf@pd.tnic>
Sender: linux-kbuild-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Christoph Hellwig <hch@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

On Monday 2017-01-23 18:26, Borislav Petkov wrote:

>On Mon, Jan 23, 2017 at 09:21:03AM -0800, Christoph Hellwig wrote:
>> Or keep the exported version as-is and never changed it, and use
>> a different copy for the kernel itself.
>
>I guess we'll have to do that if something in userspace has put its
>sticky fingers on that file and cannot be fixed. Which I hardly doubt
>but we can't break that damn userspace.

The importance of uapi headers presence is a bit overrated.

If you look at, for example, iptables (and further projects in that 
area), copies of uapi headers have been made (and this process is likely 
to continue) because it could be compiled on a variety of vintage 
systems that do not have all required #defines yet.

Similarly, it may be built on a variety of _modern_ systems whose 
kernels no longer have a particular thing (e.g. ipt_SAME), so it also 
ships copies of those headers.

So if some userspace component depends on that particular msr header (which,
unlike ipt_SAME, was not intended for export), is it not reasonable to expect
them to make a copy if and when they need it?
