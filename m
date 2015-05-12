From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 05/11] scatterlist: use sg_phys()
Date: Mon, 11 May 2015 22:44:25 -0700
Message-ID: <CAPcyv4hq5dX=HN=wYZEddOu7yX1SU4EXT0tT1hUUwKpL7txXLQ@mail.gmail.com>
References: <20150512042629.11521.70356.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150512042956.11521.32457.stgit@dwillia2-desk3.amr.corp.intel.com>
	<alpine.DEB.2.02.1505120724230.2075@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1505120724230.2075@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Rik van Riel <riel@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Mel Gorman <mgorman@suse.de>, j.glisse@gmail.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, May 11, 2015 at 10:24 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Tue, 12 May 2015, Dan Williams wrote:
>
>> Coccinelle cleanup to replace open coded sg to physical address
>> translations.  This is in preparation for introducing scatterlists that
>> reference pfn(s) without a backing struct page.
>>
>> // sg_phys.cocci: convert usage page_to_phys(sg_page(sg)) to sg_phys(sg)
>> // usage: make coccicheck COCCI=sg_phys.cocci MODE=patch
>>
>> virtual patch
>> virtual report
>> virtual org
>
> Just for information, you don't need the three lines above.  There are ony
> useful when you want the semantic patch to support several kinds of
> output.
>

Ok, I think I added them from copying a coccicheck script, and if I
delete virtual patch I get

"virtual rule patch not supported"

when running:

make coccicheck COCCI=sg_phys.cocci MODE=patch

I suspect I am invoking it wrong.
