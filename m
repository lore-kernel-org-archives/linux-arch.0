From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Question on the five-level page table support patches
Date: Mon, 24 Apr 2017 06:03:11 -0700
Message-ID: <20170424130311.GR4021@tassilo.jf.intel.com>
References: <030ea57b-5f6c-13d8-02f7-b245a754a87d@physik.fu-berlin.de>
 <CALCETrUcB7STNjVw=WBZdFfz_H1DKcLnj3HHtnGaHGQ1UY8Zrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrUcB7STNjVw=WBZdFfz_H1DKcLnj3HHtnGaHGQ1UY8Zrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

> Can you explain what the issue is?  What used to work on Linux and
> doesn't any more?  The man page is quite clear:

In old Linux hint was a search hint, so if there isn't a hole
at the hinted area it will search starting from there for a hole
instead of giving up immediately.

Now it just gives up, which means every user has to implement
their own search.

Yes I ran into the same problem and it's annoying. It broke
originally when top down mmap was added I believe

Before the augmented rbtree it was potentially very expensive, but now
it should be cheap.

-Andi
