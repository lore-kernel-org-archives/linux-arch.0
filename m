Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752915AbdLFHfv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 Dec 2017 02:35:51 -0500
Subject: Re: [PATCH 0/2] mm: introduce MAP_FIXED_SAFE
References: <20171129144219.22867-1-mhocko@kernel.org>
 <CAGXu5jLa=b2HhjWXXTQunaZuz11qUhm5aNXHpS26jVqb=G-gfw@mail.gmail.com>
 <20171130065835.dbw4ajh5q5whikhf@dhcp22.suse.cz> <20171201152640.GA3765@rei>
 <87wp20e9wf.fsf@concordia.ellerman.id.au>
 <20171206045433.GQ26021@bombadil.infradead.org>
 <20171206070355.GA32044@bombadil.infradead.org>
 <5f4fc834-274a-b8f1-bda0-5bcddc5902ed@nvidia.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <b4cc4225-d49c-51b0-dd18-e8038b5136e1@redhat.com>
Date: Wed, 6 Dec 2017 08:35:46 +0100
MIME-Version: 1.0
In-Reply-To: <5f4fc834-274a-b8f1-bda0-5bcddc5902ed@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Cyril Hrubis <chrubis@suse.cz>, Michal Hocko <mhocko@kernel.org>, Kees Cook <keescook@chromium.org>, Linux API <linux-api@vger.kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>
Message-ID: <20171206073546.XmK5ObiUciq5YdqiLjvR0GZGMfhVB8tU-nWJJ8pQ2eM@z>

On 12/06/2017 08:33 AM, John Hubbard wrote:
> In that case, maybe:
> 
>      MAP_EXACT
> 
> ? ...because that's the characteristic behavior.

Is that true?  mmap still silently rounding up the length to the page 
size, I assume, so even that name is misleading.

Thanks,
Florian
