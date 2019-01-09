Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54030 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbfAIQxx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 11:53:53 -0500
From: Chris Mason <clm@fb.com>
Subject: Re: [PATCHSET v1] io_uring IO interface
Date: Wed, 9 Jan 2019 16:27:29 +0000
Message-ID: <D240865C-6536-4838-AEEC-683DC45D0E19@fb.com>
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190109160036.GK6310@bombadil.infradead.org>
In-Reply-To: <20190109160036.GK6310@bombadil.infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "avi@scylladb.com" <avi@scylladb.com>
Message-ID: <20190109162729.a6saBURC-8NlOJeG9x_0Lq03uwk_bbYOXU9BojKCWPg@z>

On 9 Jan 2019, at 11:00, Matthew Wilcox wrote:

> On Tue, Jan 08, 2019 at 09:56:29AM -0700, Jens Axboe wrote:
>> After some arm twisting from Christoph, I finally caved and divorced=20
>> the
>> aio-poll patches from aio/libaio itself. The io_uring interface=20
>> itself
>> is useful and efficient, and after rebasing all the new goodies on=20
>> top
>> of that, there was little reason to retail the aio connection.
>>
>> Hence io_uring was born. This is what I previously called scqring for
>> aio, but now as a standalone entity. Patch #5 adds the core of this
>> interface, but in short, it has two main data structures:
>
> Please can we call it something that looks a little less like=20
> io_urine?
> aio_ring?  io_ring?  ring_io?

We must be using the same fonts, I've been harassing Jens with jokes=20
about this for days.  But, I totally missed the link between io_uring=20
and https://twitter.com/axboe/status/927571366085246976 until just now. =20
It's clear that Jens has been planning this for over a year, and he was=20
just waiting for us to catch on.


Really though, io_uring is growing on me.  The kernel is full of rings=20
and it does help set it apart.

-chris
