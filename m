From: Jonas Bonn <jonas.bonn@gmail.com>
Subject: Re: [PATCH RFC 4/8] mips: implement syscall restart generically
Date: Fri, 4 Nov 2011 10:50:44 +0100
Message-ID: <CACM3HyE09_1GTuHUryNzxLdm5uKGdkVwRmxeg4HBp9_mTWjbRA@mail.gmail.com>
References: <cover.1319364492.git.jonas@southpole.se>
	<04ce50ed7e9e9a949a3c0b447c3aec0a8c6face4.1319364492.git.jonas@southpole.se>
	<20111104093222.GA1633@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39503 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab1KDJuq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2011 05:50:46 -0400
In-Reply-To: <20111104093222.GA1633@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jonas Bonn <jonas@southpole.se>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org

On 4 November 2011 10:32, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> Nice cleanup.
>
> Any reason why you add empty version of syscall_get_arguments and
> syscall_set_version? =C2=A0A non-functional version that causes a sil=
ent
> failure is way worse than something that fails at compile time.

Good point... I'll remove those empty functions for this patch series
and look into doing a proper implementation for them later.

Thanks for the review.

/Jonas
