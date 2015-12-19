From: Sumit Gupta <sumit.g.007@gmail.com>
Subject: Query about merging memblock and bootmem into one new alloc
Date: Sat, 19 Dec 2015 19:10:26 +0530
Message-ID: <CANDtUregqtqLLa+kFSR+Hqz4dsi5jSQS1=nzUeTaXRE-wTQiyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001a1146411e64e2310527406866
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

--001a1146411e64e2310527406866
Content-Type: text/plain; charset=UTF-8

Hi All,

For ARM Linux, during booting first memblock reserves memory regions then
bootmem allocator create node, mem_map, page bitmap data and then hands
over to buddy.
I have been thinking from some time about why we need two different
allocators for this.
Can we merge both into one(memblock into bootmem) or create a new allocator
which can speed up the same thing which is easy to enhance in future.
I am not sure about this and whether it's good idea or will it be fruitful.

Please suggest and share your opinion.

Thank you in advance for your help.


-- 
Thanks & Regards,
Sumit Gupta
Mob: +91-9717222038

--001a1146411e64e2310527406866
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi All,</div><div><br></div><div>For ARM Linux, durin=
g booting first memblock reserves memory regions then bootmem allocator cre=
ate node, mem_map, page bitmap data and then hands over to buddy.</div><div=
>I have been thinking from some time about why we need two different alloca=
tors for this.</div><div>Can we merge both into one(memblock into bootmem) =
or create a new allocator which can speed up the same thing which is easy t=
o enhance in future.</div><div>I am not sure about this and whether it&#39;=
s good idea or will it be fruitful.</div><div><br></div><div>Please suggest=
 and share your opinion.</div><div><br></div><div>Thank you in advance for =
your help.</div><div><br></div><div><br></div>-- <br><div class=3D"gmail_si=
gnature">Thanks &amp; Regards,<br>Sumit Gupta<br>Mob: +91-9717222038</div>
</div>

--001a1146411e64e2310527406866--

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
