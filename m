From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: > 6 kernel arguments?
Date: Wed, 22 Feb 2012 07:02:30 -0800
Message-ID: <59d3eb2b-82f1-4de4-9dbe-7bff6e6bf8fa@email.android.com>
References: <4F43DD24.20309@zytor.com> <31890.1329903605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:50622 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab2BVPCt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Feb 2012 10:02:49 -0500
In-Reply-To: <31890.1329903605@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Linux Arch Mailing List <linux-arch@vger.kernel.org>

Yes, system call arguments.  I vaguely remember there being some architecture supporting 7 since pselect() was introduced, but I could just be full of it.

David Howells <dhowells@redhat.com> wrote:

>H. Peter Anvin <hpa@zytor.com> wrote:
>
>> Do we have any architectures which define more than 6 kernel
>arguments?
>
>To a system call, you mean?
>
>David

-- 
Sent from my mobile phone. Please excuse my brevity and lack of formatting.
