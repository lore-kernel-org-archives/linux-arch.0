From: Oren Twaig <oren@scalemp.com>
Subject: Re: [PATCH] x86, hugetlb: add missing TLB page invalidation for hugetlb_cow()
Date: Thu, 15 May 2014 10:05:05 +0300
Message-ID: <53746721.6060408@scalemp.com>
References: <20140514092948.GA17391@server-36.huawei.corp> <5372A067.9010808@sr71.net> <20140515170035.GA15779@server-36.huawei.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140515170035.GA15779@server-36.huawei.corp>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Iliopoulos <anthony.iliopoulos@huawei.com>, Dave Hansen <dave@sr71.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Shay Goikhman <shay.goikhman@huawei.com>, Paul Mundt <paul.mundt@huawei.com>, Carlos Villavieja <villavieja@hps.utexas.edu>, Nacho Navarro <nacho.navarro@bsc.es>, Avi Mendelson <avi.mendelson@tce.technion.ac.il>, Yoav Etsion <yetsion@tce.technion.ac.il>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


On 05/15/2014 08:00 PM, Anthony Iliopoulos wrote:
> I have dismissed this case, since I assume that there are many more
> cycles spent in servicing the TLB invalidation IPI, walking the pgtable
> plus other related overhead (e.g. sched) than in updating the pte/pmd
> so I am not sure how possible it would be to hit this condition.

Hi Anthony,

I have a question about the above statement. What will happen with multi
cpu VMs ? won't the race described above can happen ? I.e one virtual CPU
can will visit the host and the other will continue to encounter your race ?

Thanks,
Oren.
