From: Paul Mackerras <paulus@samba.org>
Subject: Re: Mostly portable strnlen_user()
Date: Mon, 28 May 2012 13:07:26 +1000
Message-ID: <20120528030726.GC6822@bloggs.ozlabs.ibm.com>
References: <CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
 <20120525.224318.1418525735588086513.davem@davemloft.net>
 <CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
 <20120526.001552.1171433126500742038.davem@davemloft.net>
 <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
 <CACM3HyFDY96F5kfsVCRQbx+8J+BUDCWXPqQVuLwOXRefS0Gcvg@mail.gmail.com>
 <CA+55aFxpEnd2efoU9S208L9HaOD8cvRZ38uCXr=nrhLmwgHZuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:53356 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab2E1DH4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 May 2012 23:07:56 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFxpEnd2efoU9S208L9HaOD8cvRZ38uCXr=nrhLmwgHZuw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonas Bonn <jonas@southpole.se>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org

On Sat, May 26, 2012 at 11:39:10AM -0700, Linus Torvalds wrote:

> Further testing would be good, but I feel pretty comfy about it. It
> looks fine, and when I once tried to boot a kernel with a broken
> strnlen (due to incorrect byte-endian-testing, not actually incorrect
> code otherwise), it didn't get very far at all. So this is actually
> code that gets a fair amount of coverage testing from not even doing
> anything special.

Apart from a thinko in the aligned_byte_mask definition (it's wrong
for 32-bit big-endian), it looks fine.  You're right about it not
getting very far at all; my 32-bit powerbook couldn't even mount
root.  I have sent a patch for that and one to use this stuff on
powerpc - without Ben's ack since he is off sick at the moment.

Paul.
