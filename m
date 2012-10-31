Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49775 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759734Ab2JaVkB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 17:40:01 -0400
Message-ID: <50919A7C.2080402@imgtec.com>
Date: Wed, 31 Oct 2012 21:39:08 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v1 40/40] fs: dafs: Add DAFS filesystem for metag
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>  <1351700061-7203-41-git-send-email-james.hogan@imgtec.com> <4FA345DA4F4AE44899BD2B03EEEC2FA9092A0083@SACEXCMBX04-PRD.hq.netapp.com>
In-Reply-To: <4FA345DA4F4AE44899BD2B03EEEC2FA9092A0083@SACEXCMBX04-PRD.hq.netapp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Myklebust, Trond" <Trond.Myklebust@netapp.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <20121031213908.RHbZZNUCXAD561H4riU2ldbHicie-4pFYMVbOFywpSY@z>

Hi,

On 31/10/12 19:55, Myklebust, Trond wrote:
> On Wed, 2012-10-31 at 16:14 +0000, James Hogan wrote:
>> Add the Metag Debug Adapter File System (DAFS), which uses Meta SWITCH
>> operations to communicate with a file server on a host computer via a
>> JTAG debug adapter.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: linux-fsdevel@vger.kernel.org
> 
> You might want to note that DAFS as a name for a remote filesystem is
> already taken:
> 
>   http://en.wikipedia.org/wiki/Direct_Access_File_System
> 

Hmm, thanks for pointing that out :-)

Cheers
James

