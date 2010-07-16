From: Ted Percival <ted@tedp.id.au>
Subject: Re: [PATCH 2/2] fcntl.h comment: Fix typo regarding O_SYNC
Date: Fri, 16 Jul 2010 14:51:16 -0600
Message-ID: <AANLkTikmveUqUi6Nz3F-ysbg6H0k6yfnNTJlKCT215Xu@mail.gmail.com>
References: <1279214957-10235-2-git-send-email-ted@tedp.id.au>
	<1279214957-10235-1-git-send-email-ted@tedp.id.au>
	<8130.1279274430@redhat.com>
	<20100716115639.GA16707@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54070 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758829Ab0GPUvR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2010 16:51:17 -0400
Received: by vws5 with SMTP id 5so2991261vws.19
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2010 13:51:16 -0700 (PDT)
In-Reply-To: <20100716115639.GA16707@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
> David Howells wrote:
>>
>> Ted Percival <ted@midg3t.net> wrote:
>>
>> > +/* open/fcntl - O_SYNC is only implemented on block devices and o=
n files
>> > =A0 =A0 located on an ext2 file system */
>>
>> Is this comment still true about the fact that, with respect to file=
s, this is
>> only implemented on ext2?
>
> No, it isn't.

Christoph Hellwig has since removed that comment (commit 6b2f3d1f,
"vfs: Implement proper O_SYNC semantics") so this patch (2/2) can be
ignored.
