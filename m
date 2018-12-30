Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55608 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbeL3TkW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Dec 2018 14:40:22 -0500
Message-ID: <1546198819.2844.16.camel@HansenPartnership.com>
Subject: Re: [git pull] device mapper changes for 4.21
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sun, 30 Dec 2018 11:40:19 -0800
In-Reply-To: <20181230090646.GB1022@infradead.org>
References: <20181227160944.GA12190@redhat.com>
         <20181230090646.GB1022@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>, AliOS system security <alios_sys_security@linux.alibaba.com>, Colin Ian King <colin.king@canonical.com>, Eric Biggers <ebiggers@google.com>, Heinz Mauelshagen <heinzm@redhat.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Milan Broz <gmazyland@gmail.com>, Nikos Tsironis <ntsironis@arrikto.com>, Shenghui Wang <shhuiw@foxmail.com>, Sweet Tea <sweettea@redhat.com>, wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, linux-arch@vger.kernel.org
Message-ID: <20181230194019.OEGh_cyEp7eh8FkrS7w8R2jA5spFe5ZHj8N84vq98LY@z>

On Sun, 2018-12-30 at 01:06 -0800, Christoph Hellwig wrote:
> On Thu, Dec 27, 2018 at 11:09:44AM -0500, Mike Snitzer wrote:
> > - Fix various DM targets to check for device sector overflow if
> >   CONFIG_LBDAF is not set.
> 
> Question to Jens and Linus:
> 
> is there any good reason to keep the CONFIG_LBDAF=n option around?
> Less than 2gig block devices seem to be an absolutele niche, and I
> wonder if it is still worth maintaining the special case just for
> that.

It's really a question for embedded isn't it? since they're the ones
with this set to 'n' in their default configs (linux-arch cc added). 
What LBDAF=n does is make sector_t and blkcnt_t unsigned long instead
of u64.  The maintenance burden to us is we have to use sector_div
instead of do_div in the code and remember that sector_t may be 32 bit
(the current problem in LVM).  The benefit to embedded architectures is
that they don't have to do 64 bit arithmetic for every block
transaction and the price is they can't support block devices larger
than 2TB (not 2GB, although the AF part means we can't support file
sizes bigger than 2GB).

So the first question is: is there an embedded platform where anyone
thinks the cost of the 64 bit arithmetic is important?  and if there is
can they benchmark it so we get an idea of the value of keeping LBDAF
(i.e. if it's just a few percent then likely it's not worth it, if it's
in the tens of percent, it might be).

James
