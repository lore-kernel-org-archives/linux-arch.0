From: Dave Hansen <dave@sr71.net>
Subject: Re: [PATCH] proc: mm: export PTE sizes directly in smaps (v3)
Date: Fri, 9 Dec 2016 15:10:05 -0800
Message-ID: <1103bf7b-b4a9-3378-7f09-ea67f8bed4a8@sr71.net>
References: <20161129201703.CE9D5054@viggo.jf.intel.com>
 <CAHp75Vee5EzoxOoXot0+0jRKtX+nhj+obJp-zR3Kp3osdKCVNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vee5EzoxOoXot0+0jRKtX+nhj+obJp-zR3Kp3osdKCVNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, khandual@linux.vnet.ibm.com, vbabka@suse.cz, linux-mm@kvack.org, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 12/01/2016 06:50 AM, Andy Shevchenko wrote:
>> > +static int size_shift(unsigned long long nr)
>> > +{
>> > +       if (nr < (1ULL<<10))
>> > +               return 0;
>> > +       if (nr < (1ULL<<20))
>> > +               return 10;
>> > +       if (nr < (1ULL<<30))
>> > +               return 20;
>> > +       if (nr < (1ULL<<40))
>> > +               return 30;
>> > +       if (nr < (1ULL<<50))
>> > +               return 40;
>> > +       if (nr < (1ULL<<60))
>> > +               return 50;
>> > +       return 60;
>> > +}
>> > +
> New copy of string_get_size() ?

Not really.  That prints to a buffer, so we'll need to allocate stack
space for a buffer, which we also have to size properly.  We also want
to be consistent with other parts of smaps that mean kB==1024 bytes, so
we want string_get_size()'s STRING_UNITS_10 strings, but
STRING_UNITS_2's divisor.

Also, guaranteeing that we have a power-of-2 'block size' lets us cheat
and do things much faster than using real division.  Not that it
matters, but we could do it thousands of times for a large smaps file.

Being defined locally, this stuff also gets inlined pretty aggressively.

Given all that, I'm not sure I want to modify string_get_size() to do
exactly what we need here.
