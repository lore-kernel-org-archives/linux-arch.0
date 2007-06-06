Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:51851 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758571AbXFFTGO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jun 2007 15:06:14 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id l56J6AD6030846
	for <linux-arch@vger.kernel.org>; Wed, 6 Jun 2007 12:06:10 -0700
Received: from py-out-1112.google.com (pygy77.prod.google.com [10.34.226.77])
	by zps37.corp.google.com with ESMTP id l56J4wms005473
	for <linux-arch@vger.kernel.org>; Wed, 6 Jun 2007 12:06:05 -0700
Received: by py-out-1112.google.com with SMTP id y77so461962pyg
        for <linux-arch@vger.kernel.org>; Wed, 06 Jun 2007 12:06:05 -0700 (PDT)
Message-ID: <65dd6fd50706061206y558e7f90t3740424fae7bdc9c@mail.gmail.com>
Date: Wed, 6 Jun 2007 12:06:05 -0700
From: "Ollie Wild" <aaw@google.com>
Subject: Re: [PATCH 3/4] mm: move_page_tables{,_up}
In-Reply-To: <20070605151203.738393000@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070605150523.786600000@chello.nl>
	 <20070605151203.738393000@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On 6/5/07, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> Provide functions for moving page tables upwards.

Now that we're initializing the temporary stack location to
STACK_TOP_MAX, do we still need move_page_tables_up() for variable
length argument support?  I originally added it into shift_arg_pages()
to support 32-bit apps exec'ing 64-bit apps when we were using
TASK_SIZE as our temporary location.

Maybe we should decouple this patch from the others and submit it as
an enhancement to support memory defragmentation.

Ollie
