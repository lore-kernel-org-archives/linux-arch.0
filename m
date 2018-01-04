From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Wed, 3 Jan 2018 21:49:33 -0800
Message-ID: <a558bbf3-cdc5-e95d-3954-b6f5d769c64e@intel.com>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
 <CA+55aFx7eJqRA8EWwSCrC+Lr1ZjUvRXSuhrxo+af_Dx3YWKbOQ@mail.gmail.com>
 <1515035438.20588.4.camel@intel.com>
 <20180104044424.GC21978@ZenIV.linux.org.uk>
 <CAPcyv4gKQD68dCCD-Nz78ZQ9ttung5yMzG3f+JRmGUxuKhK4Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4gKQD68dCCD-Nz78ZQ9ttung5yMzG3f+JRmGUxuKhK4Pw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "alan@linux.intel.com" <alan@linux.intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 01/03/2018 09:44 PM, Dan Williams wrote:
> No, the concern is that an fd value >= fdt->max_fds may cause the cpu
> to read arbitrary memory addresses relative to files->fdt and
> userspace can observe that it got loaded.

Yep, it potentially tells you someting about memory after fdt->fd[].
For instance, you might be able to observe if some random bit of memory
after the actual fd[] array had 'mask' set because the CPU is running
this code with a 'file' that actually fails the "fd < fdt->max_fds" check:

                file = __fcheck_files(files, fd);
                if (!file || unlikely(file->f_mode & mask))
                        return 0;
                return (unsigned long)file;
