Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ares41.inai.de ([46.4.122.207]:60693 "EHLO ares41.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbbEFLFb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 May 2015 07:05:31 -0400
Date: Wed, 6 May 2015 12:57:08 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [RFC] kernel random segmentation fault?
In-Reply-To: <55498EB0.3080904@huawei.com>
Message-ID: <alpine.LSU.2.20.1505061255360.8975@nerf40.vanv.qr>
References: <1430882810-225406-1-git-send-email-long.wanglong@huawei.com> <55498EB0.3080904@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "long.wanglong" <long.wanglong@huawei.com>
Cc: torvalds@linux-foundation.org, jay.foad@gmail.com, cwhuang@android-x86.org, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, riel@redhat.com, sasha.levin@oracle.com, Michal Hocko <mhocko@suse.cz>, dave@stgolabs.net, koct9i@gmail.com, luto@amacapital.net, pfeiner@google.com, dh.herrmann@gmail.com, vishnu.ps@samsung.com, linux-mm@kvack.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wang Kai <morgan.wang@huawei.com>, peifeiyue <peifeiyue@huawei.com>, linux-arch@vger.kernel.org
Message-ID: <20150506105708.Rb5r0we5_ZCX_cAmbO8ZbFhyqcYlfqBIZmYEuQ0d3JM@z>


On Wednesday 2015-05-06 05:46, long.wanglong wrote:
>
>int main(int argc, char** argv)
>{
>    rlim.rlim_cur=20 MB;
>    rlim.rlim_max=20 MB;
>    ret = setrlimit(RLIMIT_AS, &rlim);
>    [...]
>    char tmp[20 MB];
>    for (i = 0; i < 20 MB; i++)
>        tmp[i]=1;

if tmp already takes 20 MB, where will the remainder of the program find
space if you only allow for 20 MB? This is bound to fail under normal
considerations.
