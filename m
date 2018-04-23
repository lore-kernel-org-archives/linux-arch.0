Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751285AbeDWFov (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Apr 2018 01:44:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3N5dLJF047264
        for <linux-arch@vger.kernel.org>; Mon, 23 Apr 2018 01:44:50 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hh4nwryb9-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Apr 2018 01:44:50 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 23 Apr 2018 06:44:42 +0100
Date: Mon, 23 Apr 2018 07:44:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [REVIEW][PATCH 15/22] signal/s390: Use force_sig_fault where
 appropriate
In-Reply-To: <20180420143811.9994-15-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-15-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20180423074437.1203f39f@mschwideX1>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Message-ID: <20180423054437.JmdQlHGeH_hwMDGLIWBdH3IghNyLX9IYfslv0voq1ac@z>

On Fri, 20 Apr 2018 09:38:04 -0500
"Eric W. Biederman" <ebiederm@xmission.com> wrote:

> Filling in struct siginfo before calling force_sig_info a tedious and
> error prone process, where once in a great while the wrong fields
> are filled out, and siginfo has been inconsistently cleared.
> 
> Simplify this process by using the helper force_sig_fault.  Which
> takes as a parameters all of the information it needs, ensures
> all of the fiddly bits of filling in struct siginfo are done properly
> and then calls force_sig_info.
> 
> In short about a 5 line reduction in code for every time force_sig_info
> is called, which makes the calling function clearer.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/s390/kernel/traps.c | 32 ++++++--------------------------
>  arch/s390/mm/fault.c     | 23 ++++++-----------------
>  2 files changed, 12 insertions(+), 43 deletions(-)
 
Compiles & boots. Comparing old vs. new the same values are
set in siginfo. Looks good.

Acked-by: Martin Schwidefsky >schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
