From: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Mon, 11 Feb 2019 08:16:18 +0100
Message-ID: <0042290A-2939-4EBA-A638-D404FA2055ED@xenosoft.de>
References: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
	<594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
	<20190204075616.GA5408@lst.de>
	<ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
	<20190204123852.GA10428@lst.de>
	<b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
	<20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
	<61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
	<7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
	<20190208091818.GA23491@lst.de>
	<4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de>
Mime-Version: 1.0 (1.0)
Content-Type: multipart/mixed; boundary="===============2735983543759085288=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4e7137db-e600-0d20-6fb2-6d0f9739aca3-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Stevens <darren-YHtdit1eIT3easaKlIn9Lw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Julian Margetson <runaway-zqC88Q5qmK4@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-arch.vger.kernel.org


--===============2735983543759085288==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-AB54F82F-011B-4A2E-BF51-3599C977EE35
Content-Transfer-Encoding: 7bit


--Apple-Mail-AB54F82F-011B-4A2E-BF51-3599C977EE35
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

Mario successfully tested a kernel from your Git [1] on his T2080rdb today.

Link to the log:=20
https://gitlab.com/oshw-powerpc-notebook/T2080customizations/blob/master/ker=
nel/dma_fix/kernel_dma_fix_log.txt

He wrote:

Please, note that all of the above kernel runs just fine with the T2080rdb, h=
owever did not had the time to test extensively (tested: login into MATE gra=
phical desktop environment, used ArctiFox for opening couple of websites, th=
en played Neverball).

=E2=80=94=E2=80=94

Cheers,
Christian

[1] http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-=
dma.6=

--Apple-Mail-AB54F82F-011B-4A2E-BF51-3599C977EE35
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto">Hi Christoph,<div><br></div><div>Mario succ=
essfully tested a kernel from your Git [1] on his T2080rdb today.</div><div>=
<br></div><div>Link to the log:&nbsp;</div><div><a href=3D"https://gitlab.co=
m/oshw-powerpc-notebook/T2080customizations/blob/master/kernel/dma_fix/kerne=
l_dma_fix_log.txt">https://gitlab.com/oshw-powerpc-notebook/T2080customizati=
ons/blob/master/kernel/dma_fix/kernel_dma_fix_log.txt</a></div><div><br></di=
v><div>He wrote:</div><div><br></div><div>Please, note that all of the above=
 kernel runs just fine with the T2080rdb, however did not had the time to te=
st extensively (tested: login into MATE graphical desktop environment, used A=
rctiFox for opening couple of websites, then played Neverball).</div><div><b=
r></div><div>=E2=80=94=E2=80=94</div><div><br></div><div>Cheers,</div><div>C=
hristian</div><div><br></div><div>[1]&nbsp;<a href=3D"http://git.infradead.o=
rg/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6">http://git.infradea=
d.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6</a></div></body><=
/html>=

--Apple-Mail-AB54F82F-011B-4A2E-BF51-3599C977EE35--

--===============2735983543759085288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2735983543759085288==--
