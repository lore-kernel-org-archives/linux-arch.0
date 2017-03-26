From: Mike Galbraith <efault@gmx.de>
Subject: Re: Splat during resume
Date: Sun, 26 Mar 2017 12:10:18 +0200
Message-ID: <1490523018.5920.3.camel@gmx.de>
References: <20170325185855.4itsyevunczus7sc@pd.tnic>
         <20170325214615.eqgmkwbkyldt7wwl@pd.tnic> <1490516743.17559.7.camel@gmx.de>
         <20170326084149.pisqkhngxjd65u6g@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:59574 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbdCZKMN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 26 Mar 2017 06:12:13 -0400
In-Reply-To: <20170326084149.pisqkhngxjd65u6g@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86-ml <x86@kernel.org>

On Sun, 2017-03-26 at 10:41 +0200, Borislav Petkov wrote:

> Btw, try the 6 patches here: 
> https://marc.info/?l=linux-mm&m=148977696117208&w=2
> ontop of tip. Should fix your vaporite too.

Yeah, silicon is still happy, vaporite boots gripe free.  Trying to
hibernate vaporite was a bad idea, but is unrelated to this thread.

	-Mike
