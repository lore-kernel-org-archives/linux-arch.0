Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D83559F5;
	Fri, 24 Apr 2026 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058588; cv=none; b=Cat1B052drzh6kQPEMwLUz1Z/FXeiYh6vDzvEZYtPTpyupjTuWFo7lbiwRXO+OyHfcX6pZgTAg1vX/5fUtxiRA2Ef4XYM4vDXykXJ2yiutxGYXPLQ2BUFLK0jG7G3MhAqLlqQMdug46P4HHdTTffG9ywBFGMS+GLFArnL1RH0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058588; c=relaxed/simple;
	bh=oV31+laLRoS6I/TUNyjN2rrCKJnPvTtuWuQn+LRLZEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrsdGIhJuRZj5R0lP0VwmTPv7cJCwCxk7qWdb3TTofs1OXVqPVBaEuxAD3rc/udI2k7I36aMZP9uPH3Dd0Bff9bvMaLV7/5wxIayAbkkY9k/cHKlGxJfrFduVwWM72Hvv9lB034iNw/LDGo49uxVMTc3LpO7OkQTb5waV/YeXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BGSm0Ayh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BGSm0Ayh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=csVqsTPVwZnRAGi9vx1W5ZwqxSQGzc7MPqLazrUL+FI=; b=BGSm0AyhlQXPD4cBWWz292PN/6
	NggpRStwrlBlFg0LZS3Hb9lSTB2tkhWccIjz51pDfcCdL3/41CvKVo1mcSCDn24309i6zbCGyyYZ2
	jA0bgaB890tME+A71+BzzerccnbEM+GfyHhJNzSj/mGk6jsd4tjL9IbY0pRnj3DTJfQAKPKs7YMzz
	lTE7/U9f8BvYawwQXvN6iuVc85RHcMmt1ys0/KhpX06WdHmMgIrBxmlYIYQxSQytO8NV9Xn469fWV
	XmyFbFX/8HdNPNMfztrN4cpr/nPVgFYhnR3ynYRKWmfgAPksjrOmV+w+EmQFCtvT7o/vw545vb6bm
	g6o1QF7g==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGM71-0000000FOP4-1yUY;
	Fri, 24 Apr 2026 19:22:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F401F301142; Fri, 24 Apr 2026 21:22:50 +0200 (CEST)
Date: Fri, 24 Apr 2026 21:22:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Yosry Ahmed <yosry@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lance Yang <lance.yang@linux.dev>, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, ljs@kernel.org,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, shy828301@gmail.com, riel@surriel.com,
	jannh@google.com, jgross@suse.com, seanjc@google.com,
	pbonzini@redhat.com, boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ioworker0@gmail.com,
	roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <20260424192250.GC3783056@noisy.programming.kicks-ass.net>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex>
 <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
 <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
 <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
 <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
 <20260424190141.GA3783056@noisy.programming.kicks-ass.net>
 <E375C69C-557E-44EB-9B3C-618C9F7BA9D8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E375C69C-557E-44EB-9B3C-618C9F7BA9D8@nvidia.com>

On Fri, Apr 24, 2026 at 03:12:34PM -0400, Zi Yan wrote:
> On 24 Apr 2026, at 15:01, Peter Zijlstra wrote:
> 
> > On Fri, Apr 24, 2026 at 11:50:03AM -0700, Yosry Ahmed wrote:
> >
> >> But I imagine it's useful for reviewers to see Sashiko's feedback as
> >> well (without having to go look on the website).
> >
> > That's why I have a script; if I press 'S' in mutt on an 0/n email, said
> > script goes and does webrequest to sashiko and inserts the review
> > comments into my local maildir as properly threaded replies to the
> > series at hand.
> >
> > No looking at website needed.
> 
> Do you mind sharing that script? It looks like a great work flow. Thanks.

Sure, it is in a 'works-for-me' state and probably should get a once
over before you run it locally to make sure it fits your environment (at
the very least you should probably change my email address :-)

This is cobbled toghether from a script I got from Thomas and staring at
the JSON with generous hints from Gemini (because I can't write Python
at all).

.muttrc has:

macro index S "<pipe-entry>grep -i \"\^Message-ID:\" | cut -d: -f2- | tr -d \" <>\" | ~/bin/sashiko.py<enter>"

sashiko.py:

---
#!/usr/bin/env python3

import sys
import mailbox
import requests
from argparse import ArgumentParser
from email.message import EmailMessage
from email.utils import formatdate
from datetime import datetime

def getsash(url, msgid):
    surl = f'{url.rstrip("/")}/api/patch'
    try:
        session = requests.Session()
        session.headers.update({'User-Agent': 'sash2txt_0.2'})
        resp = session.get(surl, params={'id': msgid}, timeout=30)

        if resp.status_code == 404:
            print(f"Error: Patch ID {msgid} not found (404).", file=sys.stderr)
            return

        resp.raise_for_status()
        data = resp.json()
    except requests.RequestException as ex:
        print(f"Request failed: {ex}", file=sys.stderr)
        return

    patches = data.get('patches', [])
    if not patches:
        print(f"No patches found for (msgid).", file=sys.stderr)
        return

    msgids = {}
    subjects = {}

    for p in patches:
        msgids[p['id']] = p['message_id']
        subjects[p['id']] = p['subject']

    reviews = data.get('reviews', [])
    if not reviews:
        print(f"No reviews found for {msgid}.", file=sys.stderr)
        return

    mdir = mailbox.Maildir('~/Maildir/');

    for i, r in enumerate(reviews):
        inline = r.get('inline_review', '') or ''
        if not inline:
            continue

        author_name = r.get('author_name', 'Sashiko Reviewer')
        author_email = r.get('author_email', 'noreply@sashiko.dev')

        msgid = msgids[r['patch_id']]
        subject = subjects[r['patch_id']]

        # Create the Email object
        msg = EmailMessage()
        msg['Subject'] = f"Re: {subject}"
        msg['From'] = f"{author_name} <{author_email}>"
        msg['To'] = "peterz@infradead.org"
        msg['Date'] = formatdate(localtime=True)

        # The critical threading headers
        msg['Message-ID'] = f"<review-{i}-{msgid}>"
        msg['References'] = f"<{msgid}>"
        msg['In-Reply-To'] = f"<{msgid}>"

        msg.set_content(inline)

        mdir.add(msg)

    mdir.flush()

if __name__ == '__main__':
    url = 'https://sashiko.dev/'

    # Check if there's data in stdin (piped input)
    if not sys.stdin.isatty():
        for line in sys.stdin:
            msgid = line.strip()
            if msgid:
                getsash(url, msgid)
    else:
        # Fallback to arguments if no pipe is detected
        parser = ArgumentParser(description='Sashiko retriever to mbox')
        parser.add_argument('msgid', nargs='?', help='Message id of the patch series')
        args = parser.parse_args()

        if args.msgid:
            getsash(url, args.msgid)
        else:
            print("Usage: echo <msgid> | ./sashiko.py OR ./sashiko.py <msgid>", file=sys.stderr)
