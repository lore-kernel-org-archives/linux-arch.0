Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2on0129.outbound.protection.outlook.com ([65.55.169.129]:46152
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751153AbcFNTYw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jun 2016 15:24:52 -0400
Message-ID: <57605648.6060705@hpe.com>
Date: Tue, 14 Jun 2016 15:08:56 -0400
From: Waiman Long <waiman.long@hpe.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH-tip 6/6] xfs: Enable reader optimistic spinning for
 DAX inodes
References: <1465927959-39719-1-git-send-email-Waiman.Long@hpe.com> <1465927959-39719-7-git-send-email-Waiman.Long@hpe.com> <20160614182423.GA6330@infradead.org>
In-Reply-To: <20160614182423.GA6330@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, xfs@oss.sgi.com, Davidlohr Bueso <dave@stgolabs.net>, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160614190856.QCE790dvpeHDpUfV-dNOnilGTsR-slPsTfB_DuMbFG8@z>

On 06/14/2016 02:24 PM, Christoph Hellwig wrote:
> On Tue, Jun 14, 2016 at 02:12:39PM -0400, Waiman Long wrote:
>> This patch enables reader optimistic spinning for inodes that are
>> under a DAX-based mount point.
>>
>> On a 4-socket Haswell machine running on a 4.7-rc1 tip-based kernel,
>> the fio test with multithreaded randrw and randwrite tests on the
>> same file on a XFS partition on top of a NVDIMM with DAX were run,
>> the aggregated bandwidths before and after the patch were as follows:
> And why is this specific to DAX?  Many I/O operations already never
> got out to disk, and ilock is mostly held for operations that have
> nothing to do with disk I/O.

It is just a showcase for the rwsem change. We can certainly have more 
use cases.

Cheers,
Longman
