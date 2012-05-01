From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH -v11 17/30] resources: Add probe_resource()
Date: Tue, 1 May 2012 17:57:58 -0600
Message-ID: <CAErSpo4BZAf_i3ojXpg5WSFJ00G5i_vscVTu2va_Z3WJ0UHg=g@mail.gmail.com>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org> <1332135781-13695-18-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1332135781-13695-18-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Mar 18, 2012 at 11:42 PM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> It is changed from busn_res only version, because Bjorn found that ve=
rsion
> was not holding resource_lock.
> Even it may be ok for busn_res not holding resource_lock.
> It would be better to have it to be generic and use lock and we would
> use it for other resources.
>
> probe_resource() will try to find specified size or more in parent bu=
s.
> If can not find current parent resource, and it will try to expand pa=
rents
> top.
> If still can not find that specified on top, it will try to reduce ta=
rget size
> until find one.
>
> It will return 0, if it find any resource that it could use.
>
> Returned resource already register in the tree.
>
> So caller may still need call resource_replace to put real resource i=
n
> the tree.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> =A0include/linux/ioport.h | =A0 =A07 ++
> =A0kernel/resource.c =A0 =A0 =A0| =A0160 ++++++++++++++++++++++++++++=
++++++++++++++++++--
> =A02 files changed, 162 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index e885ba2..20a30df 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -156,6 +156,13 @@ extern int allocate_resource(struct resource *ro=
ot, struct resource *new,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *alignf_=
data);
> +void resource_shrink_parents_top(struct resource *b_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long=
 size, struct resource *parent_res);
> +struct device;
> +int probe_resource(struct resource *b_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device *dev, str=
uct resource *busn_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t needed_=
size, struct resource **p,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int skip_nr, int limit,=
 char *name);

This interface is a mess.  I have a vague impression that this is
supposed to figure out whether a resource can be expanded, but why
does it need a struct device *?  (I can read the code and see how you
use it, but it just doesn't fit in the resource abstraction.)
Supplying one struct resource * makes sense, but you have three.  A
char * name?  What's skip_nr?  This just doesn't make sense to me.

I think you need a simpler, more general interface.  update_resource()
seems OK to me -- it's pretty straightforward and has an obvious
meaning.  Maybe you can make a resource_expand() or something that
just expands a resource in both directions as far as possible (until
it hits a sibling or the parent limits).  Then you would know the
maximum possible size, and you could use update_resource() to shrink
it again and give up anything you don't need.

I spent most of the day merging the patches up to this point, and they
mostly make sense, but this one and the following ones are beyond my
ken, so I gave up.

> =A0struct resource *lookup_resource(struct resource *root, resource_s=
ize_t start);
> =A0int adjust_resource(struct resource *res, resource_size_t start,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t size);
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 7640b3a..0c9616f 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -521,14 +521,14 @@ out:
> =A0* @alignf: alignment function, optional, called if not NULL
> =A0* @alignf_data: arbitrary data to pass to the @alignf function
> =A0*/
> -int allocate_resource(struct resource *root, struct resource *new,
> +static int __allocate_resource(struct resource *root, struct resourc=
e *new,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t size, reso=
urce_size_t min,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t max, resou=
rce_size_t align,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t (*alignf)(=
void *,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0const struct resource *,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *alignf_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *alignf_data, bool loc=
k)
> =A0{
> =A0 =A0 =A0 =A0int err;
> =A0 =A0 =A0 =A0struct resource_constraint constraint;
> @@ -542,19 +542,33 @@ int allocate_resource(struct resource *root, st=
ruct resource *new,
> =A0 =A0 =A0 =A0constraint.alignf =3D alignf;
> =A0 =A0 =A0 =A0constraint.alignf_data =3D alignf_data;
>
> - =A0 =A0 =A0 if ( new->parent ) {
> + =A0 =A0 =A0 if (new->parent && lock) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* resource is already allocated, try =
reallocating with
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 the new constraints */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return reallocate_resource(root, new, =
size, &constraint);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 write_lock(&resource_lock);
> + =A0 =A0 =A0 if (lock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_lock(&resource_lock);
> =A0 =A0 =A0 =A0err =3D find_resource(root, new, size, &constraint);
> =A0 =A0 =A0 =A0if (err >=3D 0 && __request_resource(root, new))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EBUSY;
> - =A0 =A0 =A0 write_unlock(&resource_lock);
> + =A0 =A0 =A0 if (lock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_unlock(&resource_lock);
> =A0 =A0 =A0 =A0return err;
> =A0}
> +int allocate_resource(struct resource *root, struct resource *new,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t size, resou=
rce_size_t min,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t max, resour=
ce_size_t align,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t (*alignf)(v=
oid *,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 const struct resource *,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *alignf_data)
> +{
> + =A0 =A0 =A0 return __allocate_resource(root, new, size, min, max, a=
lign,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
alignf, alignf_data, true);
> +}
>
> =A0EXPORT_SYMBOL(allocate_resource);
>
> @@ -962,6 +976,142 @@ void __release_region(struct resource *parent, =
resource_size_t start,
> =A0}
> =A0EXPORT_SYMBOL(__release_region);
>
> +static void __resource_update_parents_top(struct resource *b_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long size, struct resource *parent_r=
es)
> +{
> + =A0 =A0 =A0 struct resource *res =3D b_res;
> +
> + =A0 =A0 =A0 if (!size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 while (res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res =3D=3D parent_res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end +=3D size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D res->parent;
> + =A0 =A0 =A0 }
> +}
> +
> +static void __resource_extend_parents_top(struct resource *b_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long size, struct resource *parent_r=
es)
> +{
> + =A0 =A0 =A0 __resource_update_parents_top(b_res, size, parent_res);
> +}
> +
> +void resource_shrink_parents_top(struct resource *b_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long size, struct resource *parent_r=
es)
> +{
> + =A0 =A0 =A0 write_lock(&resource_lock);
> + =A0 =A0 =A0 __resource_update_parents_top(b_res, -size, parent_res)=
;
> + =A0 =A0 =A0 write_unlock(&resource_lock);
> +}
> +
> +static resource_size_t __find_res_top_free_size(struct resource *res=
)
> +{
> + =A0 =A0 =A0 resource_size_t n_size;
> + =A0 =A0 =A0 struct resource tmp_res;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* =A0 find out number below res->end, that we can us=
e at first
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0res->start can not be used.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 n_size =3D resource_size(res) - 1;
> + =A0 =A0 =A0 memset(&tmp_res, 0, sizeof(struct resource));
> + =A0 =A0 =A0 while (n_size > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __allocate_resource(res, &tmp_r=
es, n_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end - n_size + 1, =
res->end,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, NULL, NULL, false);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __release_resource(&tmp=
_res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n_size--;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return n_size;
> +}
> +
> +int probe_resource(struct resource *b_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device *dev, =
struct resource *busn_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t need=
ed_size, struct resource **p,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int skip_nr, int lim=
it, char *name)
> +{
> + =A0 =A0 =A0 int ret =3D -ENOMEM;
> + =A0 =A0 =A0 resource_size_t n_size;
> + =A0 =A0 =A0 struct resource *parent_res =3D NULL;
> + =A0 =A0 =A0 resource_size_t tmp =3D b_res->end + 1;
> +
> +again:
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* find biggest range in b_res that we can use in the=
 middle
> + =A0 =A0 =A0 =A0* =A0and we can not use some spots from start of b_r=
es.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 n_size =3D resource_size(b_res);
> + =A0 =A0 =A0 if (n_size > skip_nr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n_size -=3D skip_nr;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n_size =3D 0;
> +
> + =A0 =A0 =A0 memset(busn_res, 0, sizeof(struct resource));
> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, dev, "find free %s in res: %pR\n=
", name, b_res);
> + =A0 =A0 =A0 while (n_size >=3D needed_size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D allocate_resource(b_res, busn_r=
es, n_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 b_res->=
start + skip_nr, b_res->end,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, NULL=
, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n_size--;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* try extend the top of parent bus, find free under to=
p at first */
> + =A0 =A0 =A0 write_lock(&resource_lock);
> + =A0 =A0 =A0 n_size =3D __find_res_top_free_size(b_res);
> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, dev, "found free %s %ld in res: =
%pR top\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, (unsigned long)n_=
size, b_res);
> +
> + =A0 =A0 =A0 /* can not extend cross local boundary */
> + =A0 =A0 =A0 if ((limit - b_res->end) < (needed_size - n_size))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto reduce_needed_size;
> +
> + =A0 =A0 =A0 /* find extended range */
> + =A0 =A0 =A0 memset(busn_res, 0, sizeof(struct resource));
> + =A0 =A0 =A0 parent_res =3D b_res;
> + =A0 =A0 =A0 while (parent_res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __allocate_resource(parent_res,=
 busn_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0needed_size - n_size=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp, tmp + needed_si=
ze - n_size - 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01, NULL, NULL, false=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* save parent_res, we =
need it as stopper later */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p =3D parent_res;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* prepare busn_res for=
 return */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __release_resource(busn=
_res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 busn_res->start -=3D n_=
size;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* extend parent bus to=
p*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __resource_extend_paren=
ts_top(b_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0needed_size - n_size, parent_res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __request_resource(b_re=
s, busn_res);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_unlock(&resource_=
lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_res =3D parent_res->parent;
> + =A0 =A0 =A0 }
> +
> +reduce_needed_size:
> + =A0 =A0 =A0 write_unlock(&resource_lock);
> + =A0 =A0 =A0 /* ret must not be 0 here */
> + =A0 =A0 =A0 needed_size--;
> + =A0 =A0 =A0 if (needed_size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again;
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/*
> =A0* Managed region resource
> =A0*/
> --
> 1.7.7
>
