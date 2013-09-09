From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 4/4] kernel: add support for init_array constructors
Date: Mon, 09 Sep 2013 10:44:03 +0930
Message-ID: <87d2oi6bl0.fsf@rustcorp.com.au>
References: <1378305776-3644-1-git-send-email-fhrbata@redhat.com> <1378305776-3644-5-git-send-email-fhrbata@redhat.com> <87vc2e66kr.fsf@rustcorp.com.au> <20130906175118.GB2332@localhost.localdomain> <20130906180751.GD25882@merlin.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130906180751.GD25882@merlin.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle McMartin <kyle@infradead.org>, Frantisek Hrbata <fhrbata@redhat.com>
Cc: linux-kernel@vger.kernel.org, jstancek@redhat.com, keescook@chromium.org, peter.oberparleiter@de.ibm.com, linux-arch@vger.kernel.org, arnd@arndb.de, mgahagan@redhat.com, agospoda@redhat.com, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Kyle McMartin <kyle@infradead.org> writes:
> On Fri, Sep 06, 2013 at 07:51:18PM +0200, Frantisek Hrbata wrote:
>> > > v2: - reuse mod->ctors for .init_array section for modules, because gcc uses
>> > >       .ctors or .init_array, but not both at the same time
>> > >
>> > > Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>
>> > 
>> > Might be nice to document which gcc version changed this, so people can
>> > choose whether to cherry-pick this change?
>> 
>> Thank you for pointing this out. As per gcc git this was introduced by commit
>> ef1da80 and released in 4.7 version.
>> 
>> $ git describe --contains ef1da80
>> gcc-4_7_0-release~4358
>> 
>> Do you want me to post v3 with this info included in the descrition?
>> 
>
> It actually depends on the combination of binutils/ld and gcc you use, not
> simply which gcc version you use. :/

Indeed, and seems it was binutils 20110507 which actually handled it
properly.

AFAICT it's theoretically possible to have .ctors and .init_array in a
module.  Unlikely, but the patch should check for both and refuse to
load the module in that case.  Otherwise weird things would happen.

Cheers,
Rusty.
