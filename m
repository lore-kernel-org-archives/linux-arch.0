Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41000 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbdK0Pvy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 10:51:54 -0500
Subject: Re: [RFC PATCH 0/2] mm: introduce MAP_FIXED_SAFE
References: <20171116101900.13621-1-mhocko@kernel.org>
 <20171116121438.6vegs4wiahod3byl@dhcp22.suse.cz>
 <20171124085405.dwln5k3dk7fdio7e@dhcp22.suse.cz>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <4f5eb24c-5af2-eebf-d54f-875f4b259793@oracle.com>
Date: Mon, 27 Nov 2017 08:51:10 -0700
MIME-Version: 1.0
In-Reply-To: <20171124085405.dwln5k3dk7fdio7e@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, linux-api@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, Kees Cook <keescook@chromium.org>
Message-ID: <20171127155110.2nvajzUHxvVW580jyPNkXoaVlKYIWGnQk9QL2mLQtgo@z>

On 11/24/2017 01:54 AM, Michal Hocko wrote:
> Are there any more concerns? So far the biggest one was the name. The
> other which suggests a flag as a modifier has been sorted out hopefully.
> Is there anymore more before we can consider this for merging? Well
> except for man page update which I will prepare of course. Can we target
> this to 4.16?

I do not have concerns with this approach. I prefer a new flag as 
opposed to a modifier and the name is ok by me.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
